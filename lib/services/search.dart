import 'package:algolia/algolia.dart';

class SearchService {
  static const _applicationId = '';
  static const _apiKey = '';

  Algolia algolia = const Algolia.init(
    applicationId: _applicationId,
    apiKey: _apiKey,
  );

  Algolia get instance => algolia.instance;
}
