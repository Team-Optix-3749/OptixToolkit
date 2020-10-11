import 'dart:convert';

import 'package:OptixToolkit/constants.dart' as Constants;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class Database {
  static Future addPart(
      IdTokenResult idToken,
      FirebaseUser user,
      String name,
      String link,
      String trackingId,
      String carrier,
      String description) async {
    var client = http.Client();
    var result = await client.post(Constants.SERVER_URL + "parts/add", body: {
      'auth': idToken.token,
      'uid': user.uid,
      'name': name,
      'link': link,
      'description': description,
      'trackingInfo': {'trackingId': trackingId, 'carrier': carrier}
    });

    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
