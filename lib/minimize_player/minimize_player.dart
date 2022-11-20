import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/global/player_controller.dart';
import 'package:music_app/models/models.dart';
import 'package:music_app/services/firebase_storage.dart';
import 'package:music_app/themes.dart';
import 'package:rxdart/rxdart.dart';

class MinimizePlayer extends StatelessWidget {
  const MinimizePlayer({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayerController>(builder: (controller) {
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
                          Text(song.name),
                          const PlayButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
    });
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
