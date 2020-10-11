// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  static bool isInProcess = false;
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future signIn(
      String email, String password, BuildContext context) async {
    if (isInProcess) return;
    isInProcess = true;
    //do login
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
    isInProcess = false;
  }

  static Future signOut() async {
    await _auth.signOut();
  }

  static Stream<FirebaseUser> AuthState() {
    return _auth.onAuthStateChanged;
  }

  static Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }
}