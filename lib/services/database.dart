import 'dart:convert';

import 'package:OptixToolkit/constants.dart' as Constants;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class FailedRequestException implements Exception {}

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
      'description': " ",
      'priority': priority.toInt(),
      'trackingInfo': {'trackingId': trackingId, 'carrier': carrier}
    };

    var body = json.encode(data);

    var result = await client.post(Constants.SERVER_URL + "parts/add",
        headers: {"Content-Type": "application/json"}, body: body);

    if (result.statusCode == 200) {
      return true;
    } else {
      print("ERROR");
      print(result.body);
      return false;
    }
  }

  static Future<List<Part>> getParts(
    IdTokenResult idToken,
  ) async {
    var client = http.Client();

    Map data = {
      'auth': idToken.token,
    };

    var body = json.encode(data);

    var result = await client.post(Constants.SERVER_URL + "parts/get",
        headers: {"Content-Type": "application/json"}, body: body);

    if (result.statusCode != 200) {
      throw new FailedRequestException();
    }

    final parsed =
        jsonDecode(result.body)['parts'].cast<Map<String, dynamic>>();

    return parsed.map<Part>((json) => Part.fromJson(json)).toList();
  }
}

final Map<String, String> deliveryMap = {
  "pre_transit": "Ordered",
  "in_transit": "Shipped",
  "out_for_delivery": "Shipped",
  "delivered": "Arrived",
  "return_to_sender": "Failure",
  "failure": "Failure",
  "unknown": "Failure",
  "Not Availible": "Failure"
};

class Part {
  final String uid;
  final String name;
  final String link;
  final String trackingId;
  final String carrier;
  final String description;
  final int priority;
  final String displayName;
  final String status;

  Part(
      {this.uid,
      this.name,
      this.link,
      this.trackingId,
      this.carrier,
      this.description,
      this.priority,
      this.displayName,
      this.status});

  factory Part.fromJson(Map<String, dynamic> json) {
    String status = json['status'];
    if (deliveryMap.containsKey(json['status'])) {
      status = deliveryMap[status];
    } else {
      status = "Faliure";
    }

    return Part(
      uid: json['uid'] as String,
      name: json['name'] as String,
      link: json['link'] as String,
      trackingId: json['trackingInfo']['trackingId'] as String,
      carrier: json['trackingInfo']['carrier'] as String,
      description: json['description'] as String,
      priority: json['priority'] as int,
      displayName: json['displayName'] as String,
      status: status,
    );
  }
}
