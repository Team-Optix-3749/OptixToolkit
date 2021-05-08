// Flutter imports:
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:OptixToolkit/services/Alert.dart';

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
      Alert.showAlert(context, e.message);
    }
    isInProcess = false;
  }

  static Future signOut() async {
    await _auth.signOut();
  }

  static Stream<FirebaseUser> authState() {
    return _auth.onAuthStateChanged;
  }

  static Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

  static Future<String> getImageUrl(File _image, FirebaseUser user) async {
    StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("user/${user.uid}/${_image.path.split('/').last}");
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;
    var downloadUrl = await storageSnapshot.ref.getDownloadURL();
    if (!uploadTask.isComplete) throw ("error");
    return downloadUrl.toString();
  }
}
