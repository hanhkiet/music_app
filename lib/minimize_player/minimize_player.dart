import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';
import 'package:music_app/global/player_controller.dart';
import 'package:music_app/models/models.dart';
import 'package:music_app/services/storage.dart';
import 'package:music_app/themes.dart';
import 'package:music_app/utils/convert.dart';
import 'package:music_app/widgets/widgets.dart';
import 'package:rxdart/rxdart.dart';

class MinimizePlayer extends GetView<PlayerController> {
  const MinimizePlayer({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: controller.audioPlayer.currentIndexStream.zipWith(
          controller.audioPlayer.sequenceStateStream,
          (i, s) => {"sequence": s, "index": i},
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData || controller.getCurrentSong == null) {
            return Container();
          }

          final Song song = controller.getCurrentSong!;

          return Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              child: InkWell(
                onTap: () => Get.toNamed('/song', arguments: [song]),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: height,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: AppTheme.accent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CoverImage(song: song),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SongTitle(song: song),
                          ),
                        ),
                        const PlayButton(),
                        const ModeButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class SongTitle extends StatelessWidget {
  const SongTitle({
    Key? key,
    required this.song,
  }) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          song.name,
          maxLines: 1,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
          overflowReplacement: SizedBox(
            height: 20,
            child: Marquee(
              text: song.name,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 40.0,
              velocity: 20.0,
              pauseAfterRound: const Duration(seconds: 1),
              accelerationDuration: const Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: const Duration(milliseconds: 500),
              decelerationCurve: Curves.linear,
            ),
          ),
        ),
        const SizedBox(height: 5),
        AutoSizeText(
          convertToNameList(song.artists).join(', '),
          maxLines: 1,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w400,
              ),
          overflowReplacement: SizedBox(
            height: 20,
            child: Marquee(
              text: convertToNameList(song.artists).join(', '),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 40.0,
              velocity: 20.0,
              pauseAfterRound: const Duration(seconds: 1),
              accelerationDuration: const Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: const Duration(milliseconds: 500),
              decelerationCurve: Curves.linear,
            ),
          ),
        ),
      ],
    );
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({
    Key? key,
    required this.song,
  }) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StorageService.getDownloadUrl('covers/${song.coverUrl}'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        String url = snapshot.data!;
        return CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (context, imageProvider) => Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          placeholder: (context, url) => Container(
            width: 50,
            height: 50,
            color: Colors.black54,
          ),
        );
      },
    );
  }
}

class PlayButton extends GetView<PlayerController> {
  const PlayButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final player = controller.audioPlayer;

    return StreamBuilder<PlayerState>(
      stream: player.playerStateStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final playerState = snapshot.data;
          final processingState = (playerState!).processingState;

          if (processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering) {
            return Container(
              width: 35,
              height: 35,
              margin: const EdgeInsets.all(10),
              child: const CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          } else if (!player.playing) {
            return IconButton(
              onPressed: player.play,
              icon: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
              ),
              iconSize: 35,
            );
          } else if (processingState != ProcessingState.completed) {
            return IconButton(
              onPressed: player.pause,
              icon: const Icon(
                Icons.pause_rounded,
                color: Colors.white,
              ),
              iconSize: 35,
            );
          } else {
            return IconButton(
              onPressed: () => player.seek(Duration.zero,
                  index: player.effectiveIndices!.first),
              icon: const Icon(
                Icons.replay_rounded,
                color: Colors.white,
              ),
              iconSize: 35,
            );
          }
        } else {
          return const CircularProgressIndicator(
            backgroundColor: Colors.white,
          );
        }
      },
    );
  }
}
