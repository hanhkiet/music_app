import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static Reference get ref => FirebaseStorage.instance.ref();

  static Future<String> getDownloadUrl(String path) {
    return ref.child(path).getDownloadURL();
  }
}
