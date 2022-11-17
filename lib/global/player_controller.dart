import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/models/models.dart';
import 'package:music_app/services/firebase_storage.dart';

class PlayerController extends GetxController {
  final Playlist playlist = Playlist();
  final currentSong = Song.empty().obs;

  final duration = Duration.zero.obs;
  final position = Duration.zero.obs;
  final loopMode = LoopMode.one.obs;

  final AudioPlayer audioPlayer = AudioPlayer();

  updateSong(Song newSong) {
    if (newSong.id != currentSong.value.id) {
      currentSong(newSong);
      position(Duration.zero);
      _updatePlayer();
    }
  }

  updatePosition(Duration newPosition) {
    position(newPosition);
    update();
  }

  updateMode(LoopMode mode) async {
    loopMode(mode);
    await audioPlayer.setLoopMode(mode);
    update();
  }

  _updatePlayer() async {
    audioPlayer.stop();

    String url = await StorageService.getDownloadUrl(
        'songs/${currentSong.value.storageRef}');

    final audioSource = LockCachingAudioSource(Uri.parse(url));

    audioPlayer.setAudioSource(audioSource);
  }
}

class Playlist {
  List<Song> songs = [];

  void add(Song newSong) => songs.add(newSong);

  void addAll(List<Song> newSongs) => songs.addAll(newSongs);

  void replace(List<Song> newSongs) => songs = newSongs;

  Song removeFirst() => songs.removeAt(0);
  Song removeLast() => songs.removeLast();
}
