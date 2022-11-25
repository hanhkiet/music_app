import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_app/models/song_model.dart';

class FirestoreService {
  static FirebaseFirestore get instance => FirebaseFirestore.instance;

  static Future<void> increasePlayCount(Song song) => instance
      .collection('songs')
      .doc(song.id)
      .update({'play_count': FieldValue.increment(1)});

  static Future<void> increaseFavoriteCount(Song song, int value) => instance
      .collection('songs')
      .doc(song.id)
      .update({'favorite_count': FieldValue.increment(value)});
}
