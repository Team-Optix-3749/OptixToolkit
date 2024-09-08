// Dart imports:
import 'dart:collection';
import 'dart:convert';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:http/http.dart' as http;
import 'package:OptixToolkit/services/Alert.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:OptixToolkit/constants.dart' as Constants;


class FailedRequestException implements Exception {}

class Database {
  static Future addPart(
      firebase.IdTokenResult idToken,
      firebase.User user,
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
      firebase.IdTokenResult idToken, String id, BuildContext context) async {
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
    firebase.IdTokenResult idToken,
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

  static Future reserveTool(firebase.IdTokenResult idToken, firebase.User user,
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

  static Future reserveToolRemove(firebase.IdTokenResult idToken, String uid,
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

  static Future changeToolStatus(
      firebase.IdTokenResult idToken,
      firebase.User user,
      String toolname,
      String newstatus,
      BuildContext context) async {
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

  static Future checkOutTool(firebase.IdTokenResult idToken, firebase.User user,
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

  static Future returnTool(firebase.IdTokenResult idToken, firebase.User user,
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

  static Future addTool(firebase.IdTokenResult idToken, String toolname,
      String category, BuildContext context) async {
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
      firebase.IdTokenResult idToken, String id, BuildContext context) async {
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
      firebase.IdTokenResult idToken, String uid, BuildContext context) async {
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

  static Future addUser(firebase.IdTokenResult idToken, String name,
      String email, bool admin, BuildContext context) async {
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
      firebase.IdTokenResult idToken, String uid, BuildContext context) async {
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

  static Future removeCertifyRole(
      firebase.IdTokenResult idToken, String uid, BuildContext context) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'uncertify-user',
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
      firebase.IdTokenResult idToken,
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

  static Future<int> getTime(
      firebase.IdTokenResult idToken, BuildContext context) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'get-seconds',
      'auth': idToken.token,
    };

    var body = json.encode(data);

    var result = await client.post(Uri.parse(Constants.SERVER_URL),
        headers: {"Content-Type": "application/json"}, body: body);

    if (result.statusCode == 200) {
      var a = jsonDecode(result.body);
      var b = a['seconds'];
      return b as int;
    } else {
      print("ERROR");
      print(result.body);
      Alert.showAlert(context, jsonDecode(result.body)['err']);
      return 0;
    }
  }

  static Future<LastCheckInTime?> getLastCheckIn(
      firebase.IdTokenResult? idToken, BuildContext context) async {
    if (idToken == null) return null;

    var client = http.Client();

    Map data = {
      'endpoint': 'get-lastcheckin',
      'auth': idToken.token,
    };

    var body = json.encode(data);

    var result = await client.post(Uri.parse(Constants.SERVER_URL),
        headers: {"Content-Type": "application/json"}, body: body);

    if (result.statusCode == 200) {
      var a = jsonDecode(result.body);
      var b = a['lastcheckin'];
      return LastCheckInTime(b as int);
    } else {
      print("ERROR");
      print(result.body);
      Alert.showAlert(context, jsonDecode(result.body)['err']);
      return LastCheckInTime(0);
    }
  }

  static Future<MeetingCount?> getMeetingCount(
      firebase.IdTokenResult? idToken, BuildContext context) async {
    if (idToken == null) return null;

    var client = http.Client();

    Map data = {
      'endpoint': 'get-meetings',
      'auth': idToken.token,
    };

    var body = json.encode(data);

    var result = await client.post(Uri.parse(Constants.SERVER_URL),
        headers: {"Content-Type": "application/json"}, body: body);

    if (result.statusCode == 200) {
      var a = jsonDecode(result.body);
      var b = a['count'];
      return MeetingCount(b as int);
    } else {
      print("ERROR");
      print(result.body);
      Alert.showAlert(context, jsonDecode(result.body)['err']);
      return MeetingCount(0);
    }
  }

  static Future checkIn(
      firebase.IdTokenResult idToken, String code, BuildContext context) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'check-in',
      'password': code,
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

  static Future checkOut(
      firebase.IdTokenResult idToken, String code, BuildContext context) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'check-out',
      'password': code,
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
    firebase.IdTokenResult idToken,
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
        category_map[tool.category]!.insert(0, tool);
      } else {
        category_map[tool.category] = [tool];
      }
    }

    print(category_map['Drill']![0].reservations);

    return category_map;
  }

  static Future<Map<String, List<Tool>>> getToolsReversed(
    firebase.IdTokenResult idToken,
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

    List<Tool> list = parsed
        .map<Tool>((json) => Tool.fromJson(json))
        .toList()
        .reversed
        .toList();

    Map<String, List<Tool>> category_map = {};

    for (var tool in list) {
      if (category_map.containsKey(tool.category)) {
        category_map[tool.category]!.insert(0, tool);
      } else {
        category_map[tool.category] = [tool];
      }
    }

    print(category_map['Drill']![0].reservations);

    return LinkedHashMap.fromEntries(category_map.entries.toList().reversed);
  }

  static Future<List<User>> getUsers(
    firebase.IdTokenResult idToken,
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

  static Future<Inventory?> getInventory(firebase.IdTokenResult idToken,
      String barcodeId, BuildContext context) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'get-inventory',
      'auth': idToken.token,
      'barcodeId': barcodeId,
    };

    var body = json.encode(data);

    var result = await client.post(Uri.parse(Constants.SERVER_URL),
        headers: {"Content-Type": "application/json"}, body: body);

    if (result.statusCode != 200) {
      Alert.showAlert(context, jsonDecode(result.body)['err']);
      return null;
    }

    if (jsonDecode(result.body)['inventory'] == null) {
      Alert.showAlert(context, "Inventoried tool does not exist!");
      return null;
    }

    final parsed =
        jsonDecode(result.body)['inventory'];

    var inventory = Inventory.fromJson(parsed);

    return inventory;
  }

  static Future<Inventory?> modifyInventory(firebase.IdTokenResult idToken,
      String barcodeId, String? newStatus, String? newLocation, BuildContext context) async {
    var client = http.Client();

    Map data = {
      'endpoint': 'modify-inventory',
      'auth': idToken.token,
      'barcodeId': barcodeId,
      'status': newStatus,
      'location': newLocation
    };

    var body = json.encode(data);

    var result = await client.post(Uri.parse(Constants.SERVER_URL),
        headers: {"Content-Type": "application/json"}, body: body);

    if (result.statusCode != 200) {
      Alert.showAlert(context, jsonDecode(result.body)['err']);
      return null;
    }

    if (jsonDecode(result.body)['inventory'] == null) {
      Alert.showAlert(context, "Inventoried tool does not exist!");
      return null;
    }

    final parsed =
        jsonDecode(result.body)['inventory'];

    var inventory = Inventory.fromJson(parsed);

    return inventory;
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
      {required this.id,
      required this.uid,
      required this.name,
      required this.link,
      required this.trackingId,
      required this.carrier,
      required this.description,
      required this.priority,
      required this.displayName,
      required this.status});

  factory Part.fromJson(Map<String, dynamic> json) {
    String status = json['status'];
    print(status + " " + json['trackingInfo']['trackingId']);
    if (deliveryMap.containsKey(json['status'])) {
      status = deliveryMap[status]!;
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

  Tool({
    required this.id,
    required this.name,
    required this.category,
    required this.user,
    required this.reservations,
    required this.status,
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
  final bool certified;
  User(
      {required this.uid,
      required this.email,
      required this.displayName,
      required this.certified});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        uid: json['uid'] as String,
        email: json['email'] as String,
        displayName: json['displayName'] as String,
        certified: json['certified'] as bool);
  }

  String toString() {
    return '${displayName}';
  }
}

class Inventory {
  final String name;
  final String description;
  final int count;
  final String barcodeId;
  final String status;
  final String location;
  Inventory(
      {required this.name,
      required this.count,
      required this.barcodeId,
      required this.description,
      required this.status,
      required this.location
      });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
        name: json['name'] as String,
        count: json['count'] as int,
        barcodeId: json['barcodeId'] as String,
        description: json['description'] as String,
        status: json['status'] as String,
        location: json['location'] as String);
  }

  String toString() {
    return name;
  }
}

class LastCheckInTime {
  late int _value;

  LastCheckInTime(int value) {
    _value = value;
  }

  int getValue() {
    return _value;
  }
}

class MeetingCount {
  int _value;

  MeetingCount(int value) : _value = value;

  int getValue() {
    return _value;
  }
}

void LogPrint(Object object) async {
  int defaultPrintLength = 1020;
  if (object.toString().length <= defaultPrintLength) {
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
