import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerButton extends StatelessWidget {
  const PlayerButton({
    Key? key,
    required this.player,
  }) : super(key: key);

  final AudioPlayer player;

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
          stream: player.playerStateStream,
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
                  child: const CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                );
              } else if (!player.playing) {
                return IconButton(
                  onPressed: player.play,
                  icon: const Icon(
                    Icons.play_circle_fill_rounded,
                    color: Colors.white,
                  ),
                  iconSize: 75,
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  onPressed: player.pause,
                  icon: const Icon(
                    Icons.pause_circle_filled_rounded,
                    color: Colors.white,
                  ),
                  iconSize: 75,
                );
              } else {
                return IconButton(
                  onPressed: () => player.seek(Duration.zero,
                      index: player.effectiveIndices!.first),
                  icon: const Icon(
                    Icons.replay_circle_filled_rounded,
                    color: Colors.white,
                  ),
                  iconSize: 75,
                );
              }
            } else {
              return const CircularProgressIndicator(
                backgroundColor: Colors.white,
              );
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
