// Flutter imports:
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:OptixToolkit/services/Alert.dart';

class Auth {
  static bool isInProcess = false;
  static firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;

  static Future signIn(
      String email, String password, BuildContext context) async {
    if (isInProcess) return;
    isInProcess = true;
    //do login
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Alert.showAlert(context, e.message);
    }
    isInProcess = false;
  }

  static Future signOut() async {
    await _auth.signOut();
  }

  static Stream<firebase.User> authState() {
    return _auth.authStateChanges();
  }

  static Future<void> sendPasswordResetEmail(
      String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      Alert.showAlert(context, e.message);
      print(e);
    }
  }

  static Future<String> getImageUrl(File _image, firebase.User user) async {
    Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("user/${user.uid}/${_image.path.split('/').last}");
    UploadTask uploadTask = firebaseStorageRef.putFile(_image);
    TaskSnapshot storageSnapshot = await uploadTask;
    var downloadUrl = await storageSnapshot.ref.getDownloadURL();
    return downloadUrl.toString();
  }
}
