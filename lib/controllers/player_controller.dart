import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/models/song_model.dart';

class PlayerController extends GetxController {
  var currentSong = Song(
    name: '',
    description: '',
    url: '',
    coverUrl: '',
  ).obs;

  final duration = Duration.zero.obs;
  final position = Duration.zero.obs;

  AudioPlayer audioPlayer = AudioPlayer();

  updateSong(Song newSong) {
    if (newSong.url != currentSong.value.url) {
      currentSong(newSong);
      position(Duration.zero);
      _updatePlayer();
    }
  }

  updatePosition(Duration newPosition) => position(newPosition);

  _updatePlayer() {
    audioPlayer.dispose();
    audioPlayer = AudioPlayer();
    audioPlayer.setAudioSource(AudioSource.uri(
      Uri.parse('asset:///${currentSong.value.url}'),
    ));
  }
}
