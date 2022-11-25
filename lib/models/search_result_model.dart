class SearchResult {
  final String id;
  final String resultType;
  final int rank;
  final String title;
  final String coverUrl;

  SearchResult({
    required this.id,
    required this.resultType,
    required this.title,
    required this.coverUrl,
    required this.rank,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      id: json['id'],
      resultType: json['result_type'],
      title: json['title'],
      coverUrl: json['cover_url'],
      rank: json['rank'],
    );
  }

  static List<SearchResult> fromData(Iterable i) {
    return List<SearchResult>.from(i.map((e) => SearchResult.fromJson(e)));
  }
}
