import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static FirebaseAuth get instance => FirebaseAuth.instance;

  static User? get currentUser => instance.currentUser;

  static Stream<User?> get authStateChanges => instance.authStateChanges();

  static Future<void> signInWithEmailAndPassword({
    required email,
    required password,
  }) async =>
      await instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

  static Future<void> createUserWithEmailAndPassword({
    required email,
    required password,
  }) async =>
      await instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

  static Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await instance.signInWithCredential(credential);
  }

  static Future<void> signOut() async {
    instance.signOut();
  }
}
