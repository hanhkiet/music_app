import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/models/models.dart';
import 'package:music_app/services/firebase_storage.dart';

class PlayerController extends GetxController {
  final Playlist _playlist = Playlist();
  bool isPlaylistPlaying = false;

  final currentSong = Song.empty().obs;

  final duration = Duration.zero.obs;
  final position = Duration.zero.obs;
  final loopMode = LoopMode.one.obs;

  final AudioPlayer audioPlayer = AudioPlayer();

  Song get getCurrentSong => _playlist.getSong(audioPlayer.currentIndex!);

  updateSong(Song newSong) {
    if (!newSong.equal(getCurrentSong)) {
      currentSong(newSong);
      position(Duration.zero);
      _updatePlayer();
    }
  }

  updatePlaylist(List<Song> newSongs) async {
    _playlist.replace(newSongs);
    isPlaylistPlaying = true;

    _stopAudioPlayer();
    AudioPlayer.clearAssetCache();

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
    audioPlayer.play();
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
    _stopAudioPlayer();

    String url = await StorageService.getDownloadUrl(
        'songs/${currentSong.value.storageRef}');

    final audioSource = LockCachingAudioSource(Uri.parse(url));

    await audioPlayer.setAudioSource(audioSource, preload: false);
    audioPlayer.play();
  }

  _stopAudioPlayer() => audioPlayer.playing ? audioPlayer.stop() : {};
}

class Playlist {
  List<Song> songs = [];

  Song getSong(int index) => songs[index];

  void add(Song newSong) => songs.add(newSong);

  void addAll(List<Song> newSongs) => songs.addAll(newSongs);

  void replace(List<Song> newSongs) => songs = newSongs;

  void clear() => songs.clear();
}
