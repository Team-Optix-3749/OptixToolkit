// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
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

  static Future<Type> readDoc<Type extends DocumentType>(
      List<String> path, Type obj) async {
    String writepath = "";
    for (String i in path) {
      writepath += i + "/";
    }
    writepath = writepath.substring(0, writepath.length - 1);
    obj.addData(await _firestore.document(writepath).get());
    return obj;
  }

  static Future<QuerySnapshot> readCollection(List<String> path) {
    String writepath = "";
    for (String i in path) {
      writepath += i + "/";
    }
    writepath = writepath.substring(0, writepath.length - 1);
    return _firestore.collection(writepath).getDocuments();
  }

  static Stream<Type> readDocListener<Type extends DocumentType>(
      List<String> path, Type obj) {
    String writepath = "";
    for (String i in path) {
      writepath += i + "/";
    }
    writepath = writepath.substring(0, writepath.length - 1);
    return _firestore
        .document(writepath)
        .snapshots()
        .map((DocumentSnapshot doc) {
      obj.addData(doc);
      return obj;
    });
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

/* Database TypeClasses */

abstract class DocumentType {
  void addData(DocumentSnapshot doc);
}

class User extends DocumentType {
  String id = "default";
  String name = "default";

  void addData(DocumentSnapshot doc) {
    Map data = doc.data;
    id = doc.documentID;
    name = data['name'] ?? '';
  }
}
