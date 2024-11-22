// Flutter imports:
import 'package:OptixToolkit/ui/tools/BarcodeResultPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:OptixToolkit/ui/tools/ToolCard.dart';
import 'package:OptixToolkit/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:OptixToolkit/ui/Loading.dart';
import 'package:provider/provider.dart';

// Package imports:
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:google_fonts/google_fonts.dart';

class toolsPage extends StatelessWidget {
  const toolsPage({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, List<Tool>>>(
      future: Database.getTools(Provider.of<firebase.IdTokenResult>(context)),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Loading();
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              return ToolWidget(
                tools: snapshot.data ?? {},
                idToken: Provider.of<firebase.IdTokenResult>(context),
              );
        }
      },
    );
  }
}

class ToolWidget extends StatefulWidget {
  Map<String, List<Tool>> tools;
  final firebase.IdTokenResult idToken;

  ToolWidget({Key? key, required this.tools, required this.idToken})
      : super(key: key);

  @override
  _toolState createState() => _toolState(this.tools, this.idToken);
}

class _toolState extends State<ToolWidget> with RouteAware {
  late Map<String, List<Tool>> tools;
  late firebase.IdTokenResult idToken;

  _toolState(Map<String, List<Tool>> tools, firebase.IdTokenResult idToken) {
    this.tools = tools;
    this.idToken = idToken;
  }

  void _showDialog(BuildContext context) {
    //dialog is the modal
    // flutter defined function
    showDialog(
      context: context, //tells flutter the context, or where we are in the app
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error!"),
          content: new Text(
              "An error has occurred, but we don't know what exactly. :("),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void refreshTools() async {
    var toolsRes = await Database.getTools(idToken);
    setState(() {
      this.tools = toolsRes;
    });
    print("Refreshsed");
  }

  @override
  void initState() {
    refreshTools();
    super.initState();
  }

  @override
  void dispose() {
    refreshTools();
    super.dispose();
  }

  Future checkOutScan() async {
    try {
      String toolname = (await BarcodeScanner.scan()).rawContent;
      print("Handling on pressed");
      print("Tool Name: " + toolname);
      var result = await Database.checkOutTool(
        Provider.of<firebase.IdTokenResult>(context, listen: false),
        Provider.of<firebase.User>(context, listen: false),
        toolname,
        context,
      );
      print("Result of the request: " + result.toString());
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        print('Camera permission not granted');
      } else {
        print('Unknown Error: $e');
      }
    } on FormatException {
      print('User pressed back button before scanning');
    } catch (e) {
      print('Unknown Error: $e');
    }
  }

  Future returnScan() async {
    try {
      String toolname = (await BarcodeScanner.scan()).rawContent;
      print("Handling on pressed");
      print("Tool Name: " + toolname);
      var result = await Database.returnTool(
        Provider.of<firebase.IdTokenResult>(context, listen: false),
        Provider.of<firebase.User>(context, listen: false),
        toolname,
        context,
      );
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        print('Camera permission not granted');
      } else {
        print('Unknown Error: $e');
      }
    } on FormatException {
      print('User pressed back button before scanning');
    } catch (e) {
      print('Unknown Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ToolCard> widgets = [];
    tools.forEach(
      (category, tools) => widgets.insert(
        0,
        ToolCard(
          category: category,
          tools: tools,
          refreshTools: refreshTools,
          key: null,
        ),
      ),
    );

    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xff3a3d41),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // ButtonTheme(
                  //   minWidth: MediaQuery.of(context).size.width * 0.43,
                  //   height: 55,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(7.0)),
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       checkOutScan().catchError((e) {
                  //         _showDialog(context);
                  //       });
                  //       refreshTools();
                  //     },
                  //     child: Text(
                  //       'CHECK OUT',
                  //       style: GoogleFonts.rubik(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 20.0,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Color(0xff159deb),
                  //     ),
                  //   ),
                  // ),
                  ElevatedButton(
                    onPressed: () {
                      _scanBarcode(
                          context); // Function to initiate barcode scanning
                    },
                    child: Text(
                      'SCAN',
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff159deb),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _showManualEntryDialog(context);
                      },
                      child: Text('Manual Entry',
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff159deb),
                      ))
                  // ButtonTheme(
                  //   minWidth: MediaQuery.of(context).size.width * 0.43,
                  //   height: 55,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(7.0)),
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       returnScan().catchError((e) {
                  //         _showDialog(context);
                  //       });
                  //       refreshTools();
                  //     },
                  //     child: Text(
                  //       'RETURN',
                  //       style: GoogleFonts.rubik(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 20.0,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Color(0xff159deb),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
            width: 400,
            height: MediaQuery.of(context).size.height * 0.63,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xff3a3d41),
            ),
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Tool ',
                              style: GoogleFonts.rubik(
                                color: Colors.white,
                                fontSize: 25.0,
                              ),
                            ),
                            TextSpan(
                              text: 'List',
                              style: GoogleFonts.rubik(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 25.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        refreshTools();
                      },
                      child: ListView(children: widgets),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to handle barcode scanning
  Future _scanBarcode(BuildContext context) async {
    try {
      String barcodeValue = (await BarcodeScanner.scan()).rawContent;

      // remove first and last digit of barcode
      barcodeValue = barcodeValue.substring(1, barcodeValue.length - 1);

      Inventory? inv =
          await Database.getInventory(idToken, barcodeValue, context);

      if (inv != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BarcodeResultPage(barcodeValue: barcodeValue, inventory: inv),
          ),
        );
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        print('Camera permission not granted');
      } else {
        print('Unknown Error: $e');
      }
    } on FormatException {
      print('User pressed back button before scanning');
    } catch (e) {
      print('Unknown Error: $e');
    }
  }

  void _showManualEntryDialog(BuildContext context) {
    TextEditingController barcodeController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Manual Barcode Entry'),
          content: TextField(
            controller: barcodeController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Enter Barcode ID'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String enteredBarcode = barcodeController.text.trim();
                if (enteredBarcode.isNotEmpty) {
                  _handleManualBarcodeEntry(context, enteredBarcode);
                } else {
                  print("This is not a valid barcode ID");
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Future _handleManualBarcodeEntry(
      BuildContext context, String enteredBarcode) async {
    String barcodeValue = enteredBarcode;
    Inventory? inv =
        await Database.getInventory(idToken, barcodeValue, context);

    if (inv != null) {
      Navigator.of(context).pop(); // Close the dialog

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BarcodeResultPage(barcodeValue: barcodeValue, inventory: inv),
        ),
      );
    }
  }
}
