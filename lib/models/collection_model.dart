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
}
