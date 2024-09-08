import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BarcodeScannerPage extends StatefulWidget {
  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  String barcode = '';
  Map<String, dynamic> inventoryEntry = {};
  List<dynamic> tools = [];
  String userID = "yourUserID"; // Replace with actual user ID

  @override
  void initState() {
    super.initState();
    _fetchTools();
  }

  // Step 3: Function to scan the barcode
  Future<void> _scanBarcode() async {
    try {
      var scanResult = await BarcodeScanner.scan();
      setState(() {
        barcode = scanResult.rawContent;
      });

      if (barcode.isNotEmpty) {
        await _postInventoryCheck();
      }
    } catch (e) {
      print(e);
    }
  }

  // Step 4: POST inventory check
  Future<void> _postInventoryCheck() async {
    var url = Uri.parse('https://toolkit.team3749.com/');
    var response = await http.post(url,
        body: jsonEncode({
          "endpoint": "post-inventory-check-tool",
          "barcodeId": barcode
        }),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      setState(() {
        inventoryEntry = jsonDecode(response.body);
      });

      await _postInventoryDecreaseCount();
      await _postToolReservation();
    } else {
      print('Failed to check inventory');
    }
  }

  // Step 5: POST inventory decrease count
  Future<void> _postInventoryDecreaseCount() async {
    var url = Uri.parse('https://toolkit.team3749.com/');
    await http.post(url,
        body: jsonEncode({
          "endpoint": "post-inventory-decrease-count-by-name",
          "name": inventoryEntry['name']
        }),
        headers: {"Content-Type": "application/json"});
  }

  // Step 6: POST tool reservation
  Future<void> _postToolReservation() async {
    var url = Uri.parse('https://toolkit.team3749.com/');
    await http.post(url,
        body: jsonEncode({
          "endpoint": "post-tool",
          "name": inventoryEntry['name'],
          "category": inventoryEntry['category'],
          "reserverID": userID
        }),
        headers: {"Content-Type": "application/json"});
  }

  // Step 7: Fetch tools
  Future<void> _fetchTools() async {
    var url = Uri.parse('https://toolkit.team3749.com/tools');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        tools = jsonDecode(response.body);
      });
    } else {
      print('Failed to fetch tools');
    }
  }

  // Step 8: Check In function
  Future<void> _checkInTool(String toolName) async {
    var deleteUrl =
        Uri.parse('https://toolkit.team3749.com/tools/$userID/$toolName');

    var deleteResponse = await http.delete(deleteUrl);

    if (deleteResponse.statusCode == 200) {
      var postUrl = Uri.parse('https://toolkit.team3749.com/');
      await http.post(postUrl,
          body: jsonEncode({
            "endpoint": "post-inventory-increase-count-by-name",
            "name": toolName
          }),
          headers: {"Content-Type": "application/json"});

      // Refresh tool list
      _fetchTools();
    } else {
      print('Failed to check in tool');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scanner'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: _scanBarcode,
            child: Text('Scan Barcode'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: tools.length,
              itemBuilder: (context, index) {
                var tool = tools[index];
                return ListTile(
                  title: Text(tool['name']),
                  trailing: ElevatedButton(
                    onPressed: () => _checkInTool(tool['name']),
                    child: Text('Check In'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
