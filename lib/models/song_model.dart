import 'package:music_app/models/models.dart';
import 'package:music_app/utils/convert.dart';

class Song {
  final String id;
  final String name;
  final int favoriteCount;
  final int playCount;
  final String coverUrl;
  final String storageRef;
  final List<Artist> artists;

  bool equals(Song? s) => s != null && id == s.id;

  Song({
    required this.id,
    required this.name,
    required this.favoriteCount,
    required this.playCount,
    required this.coverUrl,
    required this.storageRef,
    required this.artists,
  });

  factory Song.empty() {
    return Song(
      id: '',
      name: '',
      favoriteCount: 0,
      playCount: 0,
      coverUrl: '',
      storageRef: '',
      artists: [],
    );
  }

  factory Song.fromJson(Map<String, dynamic> json) {
    final artistsData =
        (json['artists'] as Iterable).map((e) => convertToJson(e));
    return Song(
      id: json['id'],
      name: json['name'],
      favoriteCount: json['favorite_count'],
      playCount: json['play_count'],
      coverUrl: json['cover_url'],
      storageRef: json['storage_ref'],
      artists: Artist.fromData(artistsData),
    );
  }

  static List<Song> fromData(Iterable i) {
    return List<Song>.from(i.map((e) => Song.fromJson(e)));
  }
}
