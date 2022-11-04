import 'dart:convert';

class Artist {
  final String name;
  final int followCount;
  final String coverUrl;

  Artist({
    required this.name,
    required this.followCount,
    required this.coverUrl,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      name: json['name'],
      followCount: json['follow_count'],
      coverUrl: json['cover_url'],
    );
  }

  static List<Artist> fromData(Iterable i) {
    return List<Artist>.from(i.map((e) => Artist.fromJson(json.decode(e))));
  }
}
