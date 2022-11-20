import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/models/models.dart';
import 'package:music_app/services/firebase_storage.dart';

class PlayerController extends GetxController {
  final Playlist _playlist = Playlist();
  bool isPlaylistPlaying = false;

  final duration = Duration.zero.obs;
  final position = Duration.zero.obs;
  final loopMode = LoopMode.off.obs;

  final AudioPlayer audioPlayer = AudioPlayer();

  Song? get getCurrentSong => audioPlayer.currentIndex != null
      ? _playlist.getSong(audioPlayer.currentIndex!)
      : null;

  updateSong(Song newSong) async {
    if (!newSong.equals(getCurrentSong)) {
      await updatePlaylist([newSong]);
    }
  }

  updatePlaylist(List<Song> newSongs, {bool shuffle = false}) async {
    _playlist.replace(newSongs);
    isPlaylistPlaying = true;

    _stopAudioPlayer();

    final playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      children: [],
    );

    for (Song song in newSongs) {
      String url =
          await StorageService.getDownloadUrl('songs/${song.storageRef}');

      final audioSource = LockCachingAudioSource(Uri.parse(url));

      await playlist.add(audioSource);
    }

    await audioPlayer.setAudioSource(playlist, initialIndex: 0, preload: false);

    await audioPlayer.play();

    update();
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

  updateShuffleMode({bool needShuffle = false}) async =>
      audioPlayer.setShuffleModeEnabled(needShuffle);

  _stopAudioPlayer() => audioPlayer.playing ? audioPlayer.stop() : {};
}

class Playlist {
  List<Song> songs = [];

  Song? getSong(int index) => index < songs.length ? songs[index] : null;

  void add(Song newSong) => songs.add(newSong);

  void addAll(List<Song> newSongs) => songs.addAll(newSongs);

  void replace(List<Song> newSongs) => songs = newSongs;

  void clear() => songs.clear();
}
