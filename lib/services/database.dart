// Dart imports:
import 'dart:convert';
import 'dart:developer';

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

    var result = await client.post(Uri.parse(Constants.SERVER_URL),
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

    var result = await client.post(Uri.parse(Constants.SERVER_URL),
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

    var result = await client.post(Uri.parse(Constants.SERVER_URL),
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

    var result = await client.post(Uri.parse(Constants.SERVER_URL),
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

  static Future reserveToolRemove(IdTokenResult idToken, String uid,
      String toolname, BuildContext context) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'remove-reservation',
      'auth': idToken.token,
      'uid': uid,
      'toolname': toolname,
    };

    var body = json.encode(data);

    var result = await client.post(Uri.parse(Constants.SERVER_URL),
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

    var result = await client.post(Uri.parse(Constants.SERVER_URL),
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

    var result = await client.post(Uri.parse(Constants.SERVER_URL),
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

    var result = await client.post(Uri.parse(Constants.SERVER_URL),
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

  static Future addTool(IdTokenResult idToken, String toolname, String category,
      BuildContext context) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'add-tool',
      'auth': idToken.token,
      'name': toolname,
      'category': category,
    };

    var body = json.encode(data);

    var result = await client.post(Uri.parse(Constants.SERVER_URL),
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

  static Future removeTool(
      IdTokenResult idToken, String id, BuildContext context) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'remove-tool',
      'id': id,
      'auth': idToken.token,
    };

    var body = json.encode(data);

    var result = await client.post(Uri.parse(Constants.SERVER_URL),
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

  static Future removeUser(
      IdTokenResult idToken, String uid, BuildContext context) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'remove-user',
      'uid': uid,
      'auth': idToken.token,
    };

    var body = json.encode(data);

    var result = await client.post(Uri.parse(Constants.SERVER_URL),
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

  static Future addUser(IdTokenResult idToken, String name, String email,
      bool admin, BuildContext context) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'create-user',
      'name': name,
      'email': email,
      'admin': admin,
      'auth': idToken.token,
    };

    var body = json.encode(data);

    var result = await client.post(Uri.parse(Constants.SERVER_URL),
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

  static Future addCertifyRole(
      IdTokenResult idToken, String uid, BuildContext context) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'certify-user',
      'uid': uid,
      'auth': idToken.token,
    };

    var body = json.encode(data);

    var result = await client.post(Uri.parse(Constants.SERVER_URL),
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

  static Future reimbursement(
      IdTokenResult idToken,
      String personName,
      String partName,
      String partLink,
      String mailingAddress,
      String pictureLink,
      String checkAddressedTo,
      BuildContext context) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'reimbursement',
      'personName': personName,
      'partName': partName,
      'partLink': partLink,
      'mailingAddress': mailingAddress,
      'pictureLink': pictureLink,
      'checkAddressedTo': checkAddressedTo,
      'auth': idToken.token,
    };

    var body = json.encode(data);

    var result = await client.post(Uri.parse(Constants.SERVER_URL),
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

    var result = await client.post(Uri.parse(Constants.SERVER_URL),
        headers: {"Content-Type": "application/json"}, body: body);

    if (result.statusCode != 200) {
      print(jsonDecode(result.body)['err']);
      throw new FailedRequestException();
    }

    LogPrint(result.body);

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

    print(category_map['Drill'][0].reservations);

    return category_map;
  }

  static Future<List<User>> getUsers(
    IdTokenResult idToken,
  ) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'list-users',
      'auth': idToken.token,
    };

    var body = json.encode(data);

    var result = await client.post(Uri.parse(Constants.SERVER_URL),
        headers: {"Content-Type": "application/json"}, body: body);

    if (result.statusCode != 200) {
      print(jsonDecode(result.body)['err']);
      throw new FailedRequestException();
    }

    final parsed =
        jsonDecode(result.body)['users'].cast<Map<String, dynamic>>();

    var users = parsed.map<User>((json) => User.fromJson(json)).toList();

    return users;
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
      {@required this.id,
      @required this.uid,
      @required this.name,
      @required this.link,
      @required this.trackingId,
      @required this.carrier,
      @required this.description,
      @required this.priority,
      @required this.displayName,
      @required this.status});

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
  final String id;
  final String name;
  final String category;
  final String user;
  final List<Map<String, dynamic>> reservations;
  final String status;
  // final List<String> reservationsUid;

  Tool({
    @required this.id,
    @required this.name,
    @required this.category,
    @required this.user,
    @required this.reservations,
    @required this.status,
    // @required this.reservationsUid,
  });

  factory Tool.fromJson(Map<String, dynamic> json) {
    var user = json['user'] as String;
    if (user == "null") user = "theres no user rn lol";

    return Tool(
      id: json['_id'] as String,
      name: json['name'] as String,
      status: json['status'] as String,
      user: json['user'] as String,
      category: json['category'] as String,
      reservations: json['reservations'].cast<Map<String, dynamic>>().toList(),
    );
  }
}

class User {
  final String uid;
  final String email;
  final String displayName;
  User({
    @required this.uid,
    @required this.email,
    @required this.displayName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        uid: json['uid'] as String,
        email: json['email'] as String,
        displayName: json['displayName'] as String);
  }

  String toString() {
    return '${displayName}';
  }
}

void LogPrint(Object object) async {
  int defaultPrintLength = 1020;
  if (object == null || object.toString().length <= defaultPrintLength) {
    print(object);
  } else {
    String log = object.toString();
    int start = 0;
    int endIndex = defaultPrintLength;
    int logLength = log.length;
    int tmpLogLength = log.length;
    while (endIndex < logLength) {
      print(log.substring(start, endIndex));
      endIndex += defaultPrintLength;
      start += defaultPrintLength;
      tmpLogLength -= defaultPrintLength;
    }
    if (tmpLogLength > 0) {
      print(log.substring(start, logLength));
    }
  }
}
