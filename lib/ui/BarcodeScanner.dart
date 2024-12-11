import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Define the backend base URL here
const String backendBaseUrl = "https://optixtoolkit-backend-production-abcd.up.railway.app/";

class ToolReservationPage extends StatefulWidget {
  @override
  _ToolReservationPageState createState() => _ToolReservationPageState();
}

class _ToolReservationPageState extends State<ToolReservationPage> {
  final Color background = const Color(0xff26292c);
  final Color lightBackground = const Color(0xff3a3d41);
  final Color blue = const Color(0xff159deb);
  final Color white = const Color(0xffffffff);

  String reserverID = "user123"; // Example reserver ID, replace with actual ID
  List<dynamic> checkedInTools = [];

  @override
  void initState() {
    super.initState();
    fetchCheckedInTools();
  }

  Future<void> scanBarcode() async {
    String barcode = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancel",
      true,
      ScanMode.BARCODE,
    );

    if (barcode != "-1") {
      await checkInTool(barcode);
    }
  }

  Future<void> checkInTool(String barcode) async {
    try {
      final response = await http.get(
        Uri.parse('$backendBaseUrl/inventory/$barcode'),
      );

      if (response.statusCode == 200) {
        final tool = json.decode(response.body);
        await http.post(
          Uri.parse('$backendBaseUrl/'),
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "endpoint": "post-tool",
            "reserverID": reserverID,
            "name": tool["name"],
          }),
        );

        fetchCheckedInTools();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${tool["name"]} checked in successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tool not found in inventory")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  Future<void> fetchCheckedInTools() async {
    try {
      final response = await http.get(
        Uri.parse('$backendBaseUrl/tools/$reserverID'),
      );

      if (response.statusCode == 200) {
        setState(() {
          checkedInTools = json.decode(response.body);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching checked-in tools")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  Future<void> checkOutTool(String name) async {
    try {
      final response = await http.delete(
        Uri.parse('$backendBaseUrl/tools/$reserverID/$name'),
      );

      if (response.statusCode == 200) {
        fetchCheckedInTools();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$name checked out successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error checking out tool")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tool Reservation",
          style: GoogleFonts.rubik(fontWeight: FontWeight.bold),
        ),
        backgroundColor: blue,
      ),
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: scanBarcode,
              style: ElevatedButton.styleFrom(
                backgroundColor: blue,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: Text(
                "Scan Barcode to Check In",
                style: GoogleFonts.rubik(color: white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Checked-In Tools:",
              style: GoogleFonts.rubik(fontSize: 20, fontWeight: FontWeight.bold, color: white),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: checkedInTools.isEmpty
                  ? Center(
                      child: Text(
                        "No tools checked in.",
                        style: GoogleFonts.rubik(color: white, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: checkedInTools.length,
                      itemBuilder: (context, index) {
                        final tool = checkedInTools[index];
                        return Card(
                          color: lightBackground,
                          child: ListTile(
                            title: Text(
                              tool["name"],
                              style: GoogleFonts.rubik(color: white),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => checkOutTool(tool["name"]),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
