import 'package:OptixToolkit/services/NavigationService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/home.dart';
import '../widgets/form.dart';
import 'package:flutter/material.dart';

class Auth {
  static bool isInProcess = false;
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static Firestore _firestore = Firestore.instance;

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

  static Future signUp(
      String email, String password, String name, BuildContext context) async {
    if (isInProcess) return;
    isInProcess = true;
    //do login
    try {
      AuthResult res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestore
          .collection("users")
          .document(res.user.uid)
          .setData({'uid': res.user.uid, 'name': name}, merge: true);
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
    isInProcess = false;
  }

  static Future signOut() async {
    await _auth.signOut();
  }

  void goToLogin() {
    NavigationService.navigateTo(PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            FormPage(isLogin: true)));
  }

  static Stream<FirebaseUser> AuthState() {
    return _auth.onAuthStateChanged;
  }
}
