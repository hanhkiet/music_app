import 'package:music_app/models/artist_model.dart';

class Song {
  final String name;
  final List<Artist> artists;
  final int playedCount;
  final int likeCount;

  Song({
    required this.name,
    required this.artists,
    required this.playedCount,
    required this.likeCount,
  });

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        name: json['name'],
        artists: [],
        playedCount: json['played_count'],
        likeCount: json['like_count'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'played_count': playedCount,
        'like_count': likeCount,
      };
}
