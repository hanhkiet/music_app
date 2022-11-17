import 'package:get/get.dart';
import 'package:music_app/global/player_controller.dart';
import 'package:music_app/models/song_model.dart';

class MinimizePlayerController extends GetxController {
  final currentSong = Song.empty().obs;
  final PlayerController playerController = Get.find();

  updateSong(newSong) => currentSong(newSong);
}
