import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/minimize_player/minimize_player_controller.dart';

class MinimizePlayer extends StatelessWidget {
  const MinimizePlayer({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MinimizePlayerController>(builder: (controller) {
      return Obx(() {
        final id = controller.currentSong.value.id;
        final songName = controller.currentSong.value.name;

        if (id.isEmpty) return Container();
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: height,
            color: Colors.red,
            child: Center(
              child: Text(songName),
            ),
          ),
        );
      });
    });
  }
}
