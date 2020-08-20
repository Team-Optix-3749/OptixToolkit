import 'package:OptixToolkit/services/NavigationService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/form.dart';
import 'package:flutter/material.dart';

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

  static Future signUp(
      String email, String password, String name, BuildContext context) async {
    if (isInProcess) return;
    isInProcess = true;
    //do login
    try {
      AuthResult res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await Database.write(
          ["users", res.user.uid], {'uid': res.user.uid, 'name': name});
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
}

class Database {
  static Firestore _firestore = Firestore.instance;

  static Future<void> write(List<String> path, Map<String, Object> data) {
    String writepath = "";
    for (String i in path) {
      writepath += i + "/";
    }
    writepath = writepath.substring(0, writepath.length - 1);
    return _firestore.document(writepath).setData(data, merge: true);
  }

  static Future<DocumentSnapshot> readDoc(List<String> path) {
    String writepath = "";
    for (String i in path) {
      writepath += i + "/";
    }
    writepath = writepath.substring(0, writepath.length - 1);
    return _firestore.document(writepath).get();
  }

  static Future<QuerySnapshot> readCollection(List<String> path) {
    String writepath = "";
    for (String i in path) {
      writepath += i + "/";
    }
    writepath = writepath.substring(0, writepath.length - 1);
    return _firestore.collection(writepath).getDocuments();
  }

  static Stream<DocumentSnapshot> readDocListener(List<String> path) {
    String writepath = "";
    for (String i in path) {
      writepath += i + "/";
    }
    writepath = writepath.substring(0, writepath.length - 1);
    return _firestore.document(writepath).snapshots();
  }

  static Stream<QuerySnapshot> readCollectionListener(List<String> path) {
    String writepath = "";
    for (String i in path) {
      writepath += i + "/";
    }
    writepath = writepath.substring(0, writepath.length - 1);
    return _firestore.collection(writepath).snapshots();
  }
}
