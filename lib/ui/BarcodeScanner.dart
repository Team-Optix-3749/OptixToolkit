import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
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
  String userID = "deltameters"; // Replace with actual user ID
  String baseUrl = "https://optixtoolkit-backend-production-abcd.up.railway.app/"; // Replace this variable later with the actual base URL

  @override
  void initState() {
    super.initState();
    _fetchTools();
  }

  // Step 3: Function to scan the barcode
  Future<void> _scanBarcode() async {
    try {
      var scanResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );

      // Check if scan was cancelled (returns '-1')
      if (scanResult != '-1' && scanResult.isNotEmpty) {
        setState(() {
          barcode = scanResult;
        });

        await _postInventoryCheck();
      } else {
        _showSnackBar('Scan was cancelled or invalid');
      }
    } catch (e) {
      print(e);
      _showSnackBar('Failed to scan barcode');
    }
  }

  // Step 4: POST inventory check
  Future<void> _postInventoryCheck() async {
    var url = Uri.parse('$baseUrl/inventory-check');

    try {
      var response = await http.post(
        url,
        body: jsonEncode({
          "endpoint": "post-inventory-check-tool",
          "barcodeId": barcode,
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        setState(() {
          inventoryEntry = jsonDecode(response.body);
        });

        await _postInventoryDecreaseCount();
        await _postToolReservation();
      } else {
        _showSnackBar('Failed to check inventory');
      }
    } catch (e) {
      print(e);
      _showSnackBar('Error checking inventory');
    }
  }

  // Step 5: POST inventory decrease count
  Future<void> _postInventoryDecreaseCount() async {
    var url = Uri.parse('$baseUrl/decrease-count');

    try {
      var response = await http.post(
        url,
        body: jsonEncode({
          "endpoint": "post-inventory-decrease-count-by-name",
          "name": inventoryEntry['name'],
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode != 200) {
        _showSnackBar('Failed to decrease inventory count');
      }
    } catch (e) {
      print(e);
      _showSnackBar('Error decreasing inventory count');
    }
  }

  // Step 6: POST tool reservation
  Future<void> _postToolReservation() async {
    var url = Uri.parse('$baseUrl/reserve-tool');

    try {
      var response = await http.post(
        url,
        body: jsonEncode({
          "endpoint": "post-tool",
          "name": inventoryEntry['name'],
          "category": inventoryEntry['category'],
          "reserverID": userID,
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode != 200) {
        _showSnackBar('Failed to reserve tool');
      }
    } catch (e) {
      print(e);
      _showSnackBar('Error reserving tool');
    }
  }

  // Step 7: Fetch tools
  Future<void> _fetchTools() async {
    var url = Uri.parse('$baseUrl/tools');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          tools = jsonDecode(response.body);
        });
      } else {
        _showSnackBar('Failed to fetch tools');
      }
    } catch (e) {
      print(e);
      _showSnackBar('Error fetching tools');
    }
  }

  // Step 8: Check In function
  Future<void> _checkInTool(String toolName) async {
    var deleteUrl = Uri.parse('$baseUrl/tools/$userID/$toolName');

    try {
      var deleteResponse = await http.delete(deleteUrl);

      if (deleteResponse.statusCode == 200) {
        var postUrl = Uri.parse('$baseUrl/increase-count');
        await http.post(
          postUrl,
          body: jsonEncode({
            "endpoint": "post-inventory-increase-count-by-name",
            "name": toolName,
          }),
          headers: {"Content-Type": "application/json"},
        );

        // Refresh tool list
        await _fetchTools();
      } else {
        _showSnackBar('Failed to check in tool');
      }
    } catch (e) {
      print(e);
      _showSnackBar('Error checking in tool');
    }
  }

  // Function to show a SnackBar with a message
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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
