import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:OptixToolkit/services/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BarcodeResultPage extends StatefulWidget {
  final String barcodeValue;
  final Inventory inventory;

  const BarcodeResultPage(
      {Key? key, required this.barcodeValue, required this.inventory})
      : super(key: key);

  @override
  State<BarcodeResultPage> createState() => _BarcodeResultPageState();
}

class _BarcodeResultPageState extends State<BarcodeResultPage> {
  Inventory? inventory;

  @override
  void initState() {
    super.initState();
    inventory = widget.inventory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff26292c),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "BARCODE RESULT",
            style: GoogleFonts.rubik(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xff159deb),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 12, top: 20, right: 12, bottom: 0),
          width: 400,
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color(0xff3a3d41),
          ),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  //Tool Name
                  'Tool Name: ${inventory!.name}',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  //Barcode Value
                  'Barcode ID: ${widget.barcodeValue}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),

                SizedBox(height: 30),

                Text(
                  // Tool Description
                  'Tool Description: ${inventory!.description}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  // Tool Count
                  'Tool Count: ${inventory!.count}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
                // Tool Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tool Status: ${inventory!.status}',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _handleChange(
                            'Tool Status', widget.inventory.status, context);
                      },
                      child:
                          Text('Change', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.blue, // Set the button color to blue
                      ),
                    ),
                  ],
                ),

                // Tool Location
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tool Location: ${inventory!.location}',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _handleChange('Tool Location',
                            widget.inventory.location, context);
                      },
                      child:
                          Text('Change', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.blue, // Set the button color to blue
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  //This is the function to handle changing tool attributes
  void _handleChange(
      String attributeName, String currentValue, BuildContext context) async {
    TextEditingController inputController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change $attributeName'),
          content: TextField(
            controller: inputController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Enter new $attributeName'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                String newValue = inputController.text.trim();
                if (newValue.isNotEmpty) {
                  Inventory? newInventory;

                  if (attributeName == "Tool Status") {
                    newInventory = await Database.modifyInventory(
                        Provider.of<firebase.IdTokenResult>(context, listen: false),
                        widget.barcodeValue,
                        newValue,
                        null,
                        context);
                  }
                  if (attributeName == "Tool Location") {
                    newInventory = await Database.modifyInventory(
                        Provider.of<firebase.IdTokenResult>(context, listen: false),
                        widget.barcodeValue,
                        null,
                        newValue,
                        context);
                  }

                  if (newInventory != null) {
                    setState(() {
                      inventory = newInventory;
                    });
                  }

                  Navigator.of(context).pop();
                } else {
                  print("Please enter a valid $attributeName");
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
