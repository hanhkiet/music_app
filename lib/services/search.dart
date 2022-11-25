import 'dart:convert';

import 'package:algolia/algolia.dart';

class SearchService {
  static const _applicationId = 'U8F5ZY6NGP';
  static const _apiKey = 'bf41f12bb181e2762c3fc112b4627742';

  Algolia algolia = const Algolia.init(
    applicationId: _applicationId,
    apiKey: _apiKey,
  );

  Algolia get instance => algolia.instance;

  searchSongs(String query) async {
    AlgoliaQuery algoliaQuery = instance.index('songs').query(query);
    AlgoliaQuerySnapshot snap = await algoliaQuery.getObjects();

    return snap.hits.map((e) {
      final map = e.toMap();
      return jsonEncode({
        'id': map['id'],
        'name': map['name'],
        'favorite_count': map['favorite_count'],
        'play_count': map['play_count'],
        'cover_url': map['cover_url'],
        'storage_ref': map['storage_ref'],
        'artists': map['artists'] as Iterable,
      });
    });
  }

  searchArtists(String artist) async {
    AlgoliaQuery algoliaQuery = instance.index('artists').query(artist);
    AlgoliaQuerySnapshot snap = await algoliaQuery.getObjects();
    return snap;
  }
}
