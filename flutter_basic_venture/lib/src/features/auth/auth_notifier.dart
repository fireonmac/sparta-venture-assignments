import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthNotifier with ChangeNotifier {
  User? _user;

  bool _isInitialized = false;

  AuthNotifier() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _isInitialized = true;
      _user = user;
      notifyListeners();
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance
        .authenticate();

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn.instance.signOut();
  }

  bool get isInitialized => _isInitialized;

  User? get user => _user;

  bool get isLoggedIn => _user != null;
}
