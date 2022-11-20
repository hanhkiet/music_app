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
        StreamBuilder<SequenceState?>(
          stream: player.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
              onPressed: player.hasPrevious ? player.seekToPrevious : null,
              icon: const Icon(
                Icons.skip_previous,
              ),
              iconSize: 40,
              color: Colors.white,
              disabledColor: Colors.white24,
            );
          },
        ),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final playerState = snapshot.data;
              final processingState = (playerState!).processingState;

              if (processingState == ProcessingState.loading ||
                  processingState == ProcessingState.buffering) {
                return Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.all(10),
                  child: const CircularProgressIndicator(
                    color: Colors.white,
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
              return Container(
                width: 30,
                height: 30,
                margin: const EdgeInsets.all(10),
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: player.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
              onPressed: player.hasNext ? player.seekToNext : null,
              icon: const Icon(
                Icons.skip_next,
              ),
              iconSize: 40,
              color: Colors.white,
              disabledColor: Colors.white24,
            );
          },
        ),
      ],
    );
  }
}
