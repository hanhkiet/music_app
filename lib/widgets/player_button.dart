import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/global/player_controller.dart';

class PlayerButton extends GetView<PlayerController> {
  const PlayerButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioPlayer player = controller.audioPlayer;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<SequenceState?>(
          stream: player.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
              onPressed: player.hasPrevious && controller.playlistLength > 1
                  ? player.seekToPrevious
                  : null,
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
            if (!snapshot.hasData) {
              return Container(
                width: 30,
                height: 30,
                margin: const EdgeInsets.all(10),
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }

            final playerState = snapshot.data;
            final processingState = (playerState!).processingState;

            if (processingState == ProcessingState.loading) {
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
                  Icons.play_circle_fill_rounded,
                  color: Colors.white,
                ),
                iconSize: 75,
              );
            }
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: player.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
              onPressed: player.hasNext && controller.playlistLength > 1
                  ? player.seekToNext
                  : null,
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
