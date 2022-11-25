class Collection {
  final String id;
  final String name;
  final String type;
  final String coverUrl;
  final int favoriteCount;
  final int playCount;

  Collection({
    required this.id,
    required this.name,
    required this.type,
    required this.coverUrl,
    required this.favoriteCount,
    required this.playCount,
  });

  factory Collection.empty() {
    return Collection(
      id: '',
      name: '',
      type: '',
      favoriteCount: 0,
      playCount: 0,
      coverUrl: '',
    );
  }

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      favoriteCount: json['favorite_count'],
      playCount: json['play_count'],
      coverUrl: json['cover_url'],
    );
  }

  static List<Collection> fromData(Iterable i) {
    return List<Collection>.from(i.map((e) => Collection.fromJson(e)));
  }
}
