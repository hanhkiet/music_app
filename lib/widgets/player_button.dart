import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerButton extends StatelessWidget {
  const PlayerButton({
    Key? key,
    required this.audioPlayer,
  }) : super(key: key);

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // StreamBuilder<SequenceState?>(
        //   stream: audioPlayer.sequenceStateStream,
        //   builder: (context, index) {
        //     return IconButton(
        //       onPressed:
        //           audioPlayer.hasPrevious ? audioPlayer.seekToPrevious : null,
        //       icon: const Icon(
        //         Icons.skip_previous,
        //         color: Colors.white,
        //       ),
        //       iconSize: 45,
        //     );
        //   },
        // ),
        StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final playerState = snapshot.data;
              final processingState = (playerState!).processingState;

              if (processingState == ProcessingState.loading ||
                  processingState == ProcessingState.buffering) {
                return Container(
                  width: 64,
                  height: 64,
                  margin: const EdgeInsets.all(10),
                  child: const CircularProgressIndicator(),
                );
              } else if (!audioPlayer.playing) {
                return IconButton(
                  onPressed: audioPlayer.play,
                  icon: const Icon(
                    Icons.play_circle_fill_rounded,
                    color: Colors.white,
                  ),
                  iconSize: 75,
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  onPressed: audioPlayer.pause,
                  icon: const Icon(
                    Icons.pause_circle_filled_rounded,
                    color: Colors.white,
                  ),
                  iconSize: 75,
                );
              } else {
                return IconButton(
                  onPressed: () => audioPlayer.seek(Duration.zero,
                      index: audioPlayer.effectiveIndices!.first),
                  icon: const Icon(
                    Icons.replay_circle_filled_rounded,
                    color: Colors.white,
                  ),
                  iconSize: 75,
                );
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        // StreamBuilder<SequenceState?>(
        //   stream: audioPlayer.sequenceStateStream,
        //   builder: (context, index) {
        //     return IconButton(
        //       onPressed: audioPlayer.hasNext ? audioPlayer.seekToNext : null,
        //       icon: const Icon(
        //         Icons.skip_next,
        //         color: Colors.white,
        //       ),
        //       iconSize: 45,
        //     );
        //   },
        // ),
      ],
    );
  }
}
