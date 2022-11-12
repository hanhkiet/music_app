import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/controllers/player_controller.dart';
import 'package:music_app/models/models.dart';
import 'package:music_app/services/firebase_storage.dart';
import 'package:music_app/widgets/seekbar.dart';
import 'package:music_app/widgets/widgets.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class SongScreen extends StatelessWidget {
  const SongScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _updatePlayer();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: const [
          Background(),
          MusicPlayer(),
        ],
      ),
    );
  }

  void _updatePlayer() {
    final Song newSong = Get.arguments;
    final PlayerController controller = Get.find();
    controller.updateSong(newSong);
  }
}

class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController = Get.find();
    final Song song = playerController.currentSong.value;

    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.2),
            Colors.black.withOpacity(0.5),
            Colors.black.withOpacity(0.9),
          ],
          stops: const [0, 0.3, 0.6],
        ).createShader(rect);
      },
      blendMode: BlendMode.darken,
      child: FutureBuilder(
        future: StorageService.getDownloadUrl('covers/${song.coverUrl}'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          String url = snapshot.data!;
          return CachedNetworkImage(
            imageUrl: url,
            imageBuilder: (context, imageProvider) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({
    Key? key,
  }) : super(key: key);

  Stream<SeekBarData> _getSeekBarDataStream(AudioPlayer audioPlayer) {
    return rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
        audioPlayer.positionStream, audioPlayer.durationStream,
        (Duration position, Duration? duration) {
      return SeekBarData(position, duration ?? Duration.zero);
    });
  }

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController = Get.find();
    final AudioPlayer audioPlayer = playerController.audioPlayer;
    final Song song = playerController.currentSong.value;

    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 40,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
            future: StorageService.getDownloadUrl('covers/${song.coverUrl}'),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              String url = snapshot.data!;
              return CachedNetworkImage(
                imageUrl: url,
                imageBuilder: (context, imageProvider) => Container(
                  width: MediaQuery.of(context).size.width * .8,
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                placeholder: (context, url) => SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  height: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 30),
          Text(
            song.name,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          StreamBuilder<SeekBarData>(
            stream: _getSeekBarDataStream(audioPlayer),
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return SeekBar(
                duration: positionData?.duration ?? Duration.zero,
                position: positionData?.position ?? Duration.zero,
                onChangedEnd: audioPlayer.seek,
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const RepeatButton(),
              PlayerButton(audioPlayer: audioPlayer),
              const PlaylistButton(),
            ],
          )
        ],
      ),
    );
  }
}

class PlaylistButton extends StatelessWidget {
  const PlaylistButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.playlist_play_rounded,
      color: Colors.white,
      size: 35,
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController = Get.find();
    return Obx(() {
      if (playerController.loopMode.value == LoopMode.off) {
        return IconButton(
          onPressed: () {
            playerController.updateMode(LoopMode.one);
          },
          icon: const Icon(
            Icons.repeat_rounded,
            color: Colors.white,
          ),
          iconSize: 35,
        );
      } else if (playerController.loopMode.value == LoopMode.one) {
        return IconButton(
          onPressed: () => playerController.updateMode(LoopMode.off),
          icon: const Icon(
            Icons.repeat_one_rounded,
            color: Colors.white,
          ),
          iconSize: 35,
        );
      } else {
        return const Icon(
          Icons.error,
          color: Colors.white,
          size: 35,
        );
      }
    });
  }
}
