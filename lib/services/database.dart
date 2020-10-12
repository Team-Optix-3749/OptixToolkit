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
      String description,
      double priority) async {
    var client = http.Client();

    Map data = {
      'auth': idToken.token,
      'uid': user.uid,
      'name': name,
      'link': link,
      'description': description,
      'priority': priority.toInt(),
      'trackingInfo': {'trackingId': trackingId, 'carrier': carrier}
    };

    var body = json.encode(data);

    var result = await client.post(Constants.SERVER_URL + "parts/add", 
      headers: {"Content-Type": "application/json"},
      body: body
    );

    if (result.statusCode == 200) {
      return true;
    } else {
      print("ERROR");
      print(result.body);
      return false;
    }
  }
}
