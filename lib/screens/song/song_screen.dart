import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/controllers/player_controller.dart';
import 'package:music_app/widgets/seekbar.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class SongScreen extends StatelessWidget {
  const SongScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController = Get.find();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: const [BackgroundFilter(), MusicPlayer()],
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
    final controller = Get.find<PlayerController>();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 60,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          // Text(
          //   song.name,
          //   style: Theme.of(context)
          //       .textTheme
          //       .headlineSmall!
          //       .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          // ),
          // const SizedBox(height: 10),
          // Text(
          //   song.description,
          //   maxLines: 2,
          //   style: Theme.of(context)
          //       .textTheme
          //       .bodySmall!
          //       .copyWith(color: Colors.white),
          // ),
          // const SizedBox(height: 30),
          // StreamBuilder<SeekBarData>(
          //   stream: _getSeekBarDataStream(audioPlayer),
          //   builder: (context, snapshot) {
          //     final positionData = snapshot.data;
          //     return SeekBar(
          //       duration: positionData?.duration ?? Duration.zero,
          //       position: positionData?.position ?? Duration.zero,
          //       onChangedEnd: audioPlayer.seek,
          //     );
          //   },
          // ),
          // PlayerButton(audioPlayer: audioPlayer)
        ],
      ),
    );
  }
}

class BackgroundFilter extends StatelessWidget {
  const BackgroundFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white.withOpacity(.5),
            Colors.white.withOpacity(0),
          ],
          stops: const [0, .3, .6],
        ).createShader(rect);
      },
      blendMode: BlendMode.xor,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 150, 158),
              Color.fromARGB(255, 0, 242, 255),
            ],
          ),
        ),
      ),
    );
  }
}
