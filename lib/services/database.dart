// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:OptixToolkit/services/Alert.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:OptixToolkit/constants.dart' as Constants;

import 'package:flutter/foundation.dart';

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
      double priority,
      BuildContext context) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'parts-add',
      'auth': idToken.token,
      'uid': user.uid,
      'name': name,
      'link': link,
      'description': " ",
      'priority': priority.toInt(),
      'trackingInfo': {'trackingId': trackingId, 'carrier': carrier}
    };

    var body = json.encode(data);

    var result = await client.post(Constants.SERVER_URL,
        headers: {"Content-Type": "application/json"}, body: body);

    if (result.statusCode == 200) {
      return true;
    } else {
      print("ERROR");
      print(result.body);
      Alert.showAlert(context, jsonDecode(result.body)['err']);
      return false;
    }
  }

  static Future removePart(
      IdTokenResult idToken, String id, BuildContext context) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'parts-remove',
      'id': id,
      'auth': idToken.token,
    };

    var body = json.encode(data);

    var result = await client.post(Constants.SERVER_URL,
        headers: {"Content-Type": "application/json"}, body: body);

    if (result.statusCode == 200) {
      return true;
    } else {
      print("ERROR");
      print(result.body);
      Alert.showAlert(context, jsonDecode(result.body)['err']);
      return false;
    }
  }

  static Future<List<Part>> getParts(
    IdTokenResult idToken,
  ) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'parts-get',
      'auth': idToken.token,
    };

    var body = json.encode(data);

    var result = await client.post(Constants.SERVER_URL,
        headers: {"Content-Type": "application/json"}, body: body);

    if (result.statusCode != 200) {
      print(result.body);
      throw new FailedRequestException();
    }

    final jsonParts = jsonDecode(result.body)['parts'];

    //print(jsonParts);

    final parsed = jsonParts.cast<Map<String, dynamic>>();

    return parsed.map<Part>((json) => Part.fromJson(json)).toList();
  }

  static Future reserveTool(IdTokenResult idToken, FirebaseUser user,
      String toolname, BuildContext context) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'reserve-tool',
      'auth': idToken.token,
      'uid': user.uid,
      'toolname': toolname,
    };

    var body = json.encode(data);

    var result = await client.post(Constants.SERVER_URL,
        headers: {"Content-Type": "application/json"}, body: body);

    if (result.statusCode == 200) {
      return true;
    } else {
      print("ERROR");
      print(result.body);
      Alert.showAlert(context, jsonDecode(result.body)['err']);
      return false;
    }
  }

  static Future changeToolStatus(IdTokenResult idToken, FirebaseUser user,
      String toolname, String newstatus, BuildContext context) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'change-tool-status',
      'auth': idToken.token,
      'toolname': toolname,
      'newtoolstatus': newstatus,
    };

    var body = json.encode(data);

    var result = await client.post(Constants.SERVER_URL,
        headers: {"Content-Type": "application/json"}, body: body);

    if (result.statusCode == 200) {
      return true;
    } else {
      print("ERROR");
      print(result.body);
      Alert.showAlert(context, jsonDecode(result.body)['err']);
      return false;
    }
  }

  static Future checkOutTool(IdTokenResult idToken, FirebaseUser user,
      String toolname, BuildContext context) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'checkout-tool',
      'auth': idToken.token,
      'uid': user.uid,
      'toolname': toolname,
    };

    var body = json.encode(data);

    var result = await client.post(Constants.SERVER_URL,
        headers: {"Content-Type": "application/json"}, body: body);

    if (result.statusCode == 200) {
      return true;
    } else {
      print("ERROR");
      print(result.body);
      Alert.showAlert(context, jsonDecode(result.body)['err']);
      return false;
    }
  }

  static Future returnTool(IdTokenResult idToken, FirebaseUser user,
      String toolname, BuildContext context) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'return-tool',
      'auth': idToken.token,
      'uid': user.uid,
      'toolname': toolname,
    };

    var body = json.encode(data);

    var result = await client.post(Constants.SERVER_URL + "tools/return_tool",
        headers: {"Content-Type": "application/json"}, body: body);

    if (result.statusCode == 200) {
      return true;
    } else {
      print("ERROR");
      print(result.body);
      Alert.showAlert(context, jsonDecode(result.body)['err']);
      return false;
    }
  }

  static Future<Map<String, List<Tool>>> getTools(
    IdTokenResult idToken,
  ) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'get-tools',
      'auth': idToken.token,
    };

    var body = json.encode(data);

    var result = await client.post(Constants.SERVER_URL,
        headers: {"Content-Type": "application/json"}, body: body);

    if (result.statusCode != 200) {
      print(jsonDecode(result.body)['err']);
      throw new FailedRequestException();
    }

    final parsed =
        jsonDecode(result.body)['tools'].cast<Map<String, dynamic>>();

    List<Tool> list = parsed.map<Tool>((json) => Tool.fromJson(json)).toList();

    Map<String, List<Tool>> category_map = {};

    for (var tool in list) {
      if (category_map.containsKey(tool.category)) {
        category_map[tool.category as String].insert(0, tool);
      } else {
        category_map[tool.category as String] = [tool];
      }
    }

    return category_map;
  }
}

final Map<String, String> deliveryMap = {
  "pre_transit": "Ordered",
  "in_transit": "Shipped",
  "out_for_delivery": "Shipped",
  "delivered": "Arrived",
  "return_to_sender": "Failure",
  "failure": "Failure",
  "unknown": "Ordered",
  "Not Availible": "Failure"
};

class Part {
  final String id;
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
      {this.id,
      this.uid,
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
    print(status + " " + json['trackingInfo']['trackingId']);
    if (deliveryMap.containsKey(json['status'])) {
      status = deliveryMap[status];
    } else {
      status = "Faliure";
    }

    return Part(
      id: json['_id'] as String,
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

class Tool {
  final String name;
  final String category;
  final String user;
  final List<String> reservations;
  final String status;

  Tool({
    @required this.name,
    @required this.category,
    @required this.user,
    @required this.reservations,
    @required this.status,
  });

  factory Tool.fromJson(Map<String, dynamic> json) {
    var user = json['user'] as String;
    if (user == "null") user = "theres no user rn lol";

    return Tool(
      name: json['name'] as String,
      status: json['status'] as String,
      user: json['user'] as String,
      category: json['category'] as String,
      reservations: json['reservations'].cast<String>().toList(),
    );
  }
}
