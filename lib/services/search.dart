import 'package:algolia/algolia.dart';

class SearchService {
  static const _applicationId = 'U8F5ZY6NGP';
  static const _apiKey = 'bf41f12bb181e2762c3fc112b4627742';

  Algolia algolia = const Algolia.init(
    applicationId: _applicationId,
    apiKey: _apiKey,
  );

  Algolia get instance => algolia.instance;

  searchResults(String query) async {
    final songs = await searchSongs(query);
    final artists = await searchArtists(query);
    final collections = await searchCollections(query);

    final List result = [];
    result.addAll(songs);
    result.addAll(artists);
    result.addAll(collections);
    result.sort((a, b) => int.parse(a['rank'].toString())
        .compareTo(int.parse(b['rank'].toString())));

    return result;
  }

  searchSongs(String query) async {
    AlgoliaQuery algoliaQuery = instance.index('songs').query(query);
    AlgoliaQuerySnapshot snap = await algoliaQuery.getObjects();

    return snap.hits.map((e) {
      final map = e.toMap();
      return {
        'id': map['id'],
        'result_type': 'song',
        'title': map['name'],
        'cover_url': map['cover_url'],
        'rank': int.parse(map['play_count'].toString()),
      };
    }).toList();
  }

  searchArtists(String query) async {
    AlgoliaQuery algoliaQuery = instance.index('artists').query(query);
    AlgoliaQuerySnapshot snap = await algoliaQuery.getObjects();

    return snap.hits.map((e) {
      final map = e.toMap();
      return {
        'item_id': map['id'],
        'result_type': 'artist',
        'title': map['name'],
        'cover_url': map['cover_url'],
        'rank': int.parse(map['follow_count'].toString()),
      };
    }).toList();
  }

  searchCollections(String query) async {
    AlgoliaQuery algoliaQuery = instance.index('collections').query(query);
    AlgoliaQuerySnapshot snap = await algoliaQuery.getObjects();

    return snap.hits.map((e) {
      final map = e.toMap();
      return {
        'item_id': map['id'],
        'result_type': map['type'] == 'album' ? 'album' : 'playlist',
        'title': map['name'],
        'cover_url': map['cover_url'],
        'rank': int.parse(map['play_count'].toString()),
      };
    }).toList();
  }
}
