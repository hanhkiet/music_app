import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/global/player_controller.dart';

class ModeButton extends StatelessWidget {
  const ModeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController = Get.find();

    if (playerController.playlistLength == 1) {
      return Obx(() {
        if (playerController.loopMode.value == LoopMode.one) {
          return IconButton(
            onPressed: () => playerController.updateMode(LoopMode.off),
            icon: const Icon(
              Icons.repeat_one_rounded,
              color: Colors.white,
            ),
            iconSize: 35,
          );
        } else {
          return IconButton(
            onPressed: () => playerController.updateMode(LoopMode.one),
            icon: Icon(
              Icons.repeat_one_rounded,
              color: Colors.white.withOpacity(0.2),
            ),
            iconSize: 35,
          );
        }
      });
    }

    return Obx(() {
      if (playerController.isShuffled.value) {
        return IconButton(
          onPressed: () {
            playerController.updateShuffleMode(false);
            playerController.updateMode(LoopMode.off);
          },
          icon: const Icon(
            Icons.shuffle_rounded,
            color: Colors.white,
          ),
          iconSize: 35,
        );
      } else {
        if (playerController.loopMode.value == LoopMode.one) {
          return IconButton(
            onPressed: () {
              playerController.updateShuffleMode(false);
              playerController.audioPlayer.setShuffleModeEnabled(false);
              playerController.updateMode(LoopMode.all);
            },
            icon: const Icon(
              Icons.repeat_one_rounded,
              color: Colors.white,
            ),
            iconSize: 35,
          );
        } else if (playerController.loopMode.value == LoopMode.all) {
          return IconButton(
            onPressed: () {
              playerController.updateShuffleMode(true);
              playerController.audioPlayer.setShuffleModeEnabled(true);
              playerController.updateMode(LoopMode.off);
            },
            icon: const Icon(
              Icons.repeat_rounded,
              color: Colors.white,
            ),
            iconSize: 35,
          );
        } else {
          return IconButton(
            onPressed: () {
              playerController.updateShuffleMode(false);
              playerController.audioPlayer.setShuffleModeEnabled(false);
              playerController.updateMode(LoopMode.one);
            },
            icon: Icon(
              Icons.repeat_rounded,
              color: Colors.white.withOpacity(0.2),
            ),
            iconSize: 35,
          );
        }
      }
    });
  }
}
