import 'dart:convert';

class Song {
  final String name;
  final int favoriteCount;
  final int playCount;
  final String coverUrl;

  Song({
    required this.name,
    required this.favoriteCount,
    required this.playCount,
    required this.coverUrl,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      name: json['name'],
      favoriteCount: json['favorite_count'],
      playCount: json['play_count'],
      coverUrl: json['cover_url'],
    );
  }

  static List<Song> fromData(Iterable i) {
    return List<Song>.from(i.map((e) => Song.fromJson(json.decode(e))));
  }
}
