import 'dart:convert';

class Song {
  final String name;
  final int favoriteCount;
  final int playCount;
  final String coverUrl;
  final String storageRef;

  Song({
    required this.name,
    required this.favoriteCount,
    required this.playCount,
    required this.coverUrl,
    required this.storageRef,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      name: json['name'],
      favoriteCount: json['favorite_count'],
      playCount: json['play_count'],
      coverUrl: json['cover_url'],
      storageRef: json['storage_ref'],
    );
  }

  factory Song.empty() {
    return Song(
      name: '',
      favoriteCount: 0,
      playCount: 0,
      coverUrl: '',
      storageRef: '',
    );
  }

  static List<Song> fromData(Iterable i) {
    return List<Song>.from(i.map((e) => Song.fromJson(json.decode(e))));
  }
}
