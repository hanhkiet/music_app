import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/models/models.dart';
import 'package:music_app/services/firebase_storage.dart';

class PlayerController extends GetxController {
  final currentSong = Song.empty().obs;

  final duration = Duration.zero.obs;
  final position = Duration.zero.obs;

  AudioPlayer audioPlayer = AudioPlayer();

  updateSong(Song newSong) {
    if (newSong.storageRef != currentSong.value.storageRef) {
      currentSong(newSong);
      position(Duration.zero);
      _updatePlayer();
    }
  }

  updatePosition(Duration newPosition) => position(newPosition);

  _updatePlayer() async {
    audioPlayer.dispose();
    audioPlayer = AudioPlayer();

    String url = await StorageService.getDownloadUrl(
        'songs/${currentSong.value.storageRef}');

    audioPlayer.setAudioSource(AudioSource.uri(
      Uri.parse(url),
    ));
  }
}
