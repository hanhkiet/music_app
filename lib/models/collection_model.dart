import 'song_model.dart';

class Collection {
  final String title;
  final List<Song> songs;
  final String imageUrl;

  Collection({
    required this.title,
    required this.songs,
    required this.imageUrl,
  });

  static List<Collection> collectionSamples = [
    Collection(
      title: 'Tren tinh ban',
      songs: Song.sampleSongs,
      imageUrl: 'samples/covers/tren-tinh-ban.jpeg',
    ),
    Collection(
      title: 'Tren tinh ban',
      songs: Song.sampleSongs,
      imageUrl: 'samples/covers/tren-tinh-ban.jpeg',
    ),
    Collection(
      title: 'Tren tinh ban',
      songs: Song.sampleSongs,
      imageUrl: 'samples/covers/tren-tinh-ban.jpeg',
    ),
    Collection(
      title: 'Tren tinh ban',
      songs: Song.sampleSongs,
      imageUrl: 'samples/covers/tren-tinh-ban.jpeg',
    ),
  ];
}
