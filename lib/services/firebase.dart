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

  static Future<void> signUp(
      String email, String password, BuildContext context) async {
    if (isInProcess) return;
    isInProcess = true;
    try {
      // Create a new user
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Show a success message
      Alert.showAlert(context, "Account created successfully!");
      Navigator.pop(context); // Navigate back to the login page
    } on firebase.FirebaseAuthException catch (e) {
      // Handle authentication errors
      Alert.showAlert(context, e.message ?? "Unknown authentication error");
    } finally {
      isInProcess = false;
    }
  }

  static Future<void> signIn(
      String email, String password, BuildContext context) async {
    if (isInProcess) return;
    isInProcess = true;
    try {
      // Log in the user
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on firebase.FirebaseAuthException catch (e) {
      Alert.showAlert(context, e.message ?? "Unknown authentication error");
    }
    isInProcess = false;
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Stream<firebase.User?> authState() {
    return _auth.authStateChanges();
  }

  static Future<void> sendPasswordResetEmail(
      String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on firebase.FirebaseAuthException catch (e) {
      Alert.showAlert(context, e.message ?? "Unknown authentication error");
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
