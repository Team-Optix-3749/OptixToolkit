// Flutter imports:
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
  const toolsPage({required Key key, required this.uid}) : super(key: key);
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
                tools: snapshot.data,
                idToken: Provider.of<firebase.IdTokenResult>(context), key: null,
              );
        }
      },
    );
  }
}

class ToolWidget extends StatefulWidget {
  Map<String, List<Tool>> tools;
  final firebase.IdTokenResult idToken;

  ToolWidget({required Key key, required  this.tools, required this.idToken}) : super(key: key);

  @override
  _toolState createState() => _toolState(this.tools, this.idToken);
}

class _toolState extends State<ToolWidget> with RouteAware {
  Map<String, List<Tool>> tools;
  firebase.IdTokenResult idToken;

  _toolState(Map<String, List<Tool>> tools, firebase.IdTokenResult idToken) {
    this.tools = tools;
    this.idToken = idToken;
  }

  void _showDialog(BuildContext context) { //dialog is the modal
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
    } on FormatException catch (e) {
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
    } on FormatException catch (e) {
      print('User pressed back button before scanning');
    } catch (e) {
      print('Unknown Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ToolCard> widgets = [];
    tools.forEach((category, tools) => widgets.insert(
        0,
        ToolCard(
          category: category,
          tools: tools,
          refreshTools: refreshTools, key: null,
        )));

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
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.43,
                    height: 55,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    child: ElevatedButton(
                      onPressed: () {
                        checkOutScan().catchError(() {
                          _showDialog(context);
                        });
                        refreshTools();
                      },
                      child: Text(
                        'CHECK OUT',
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(backgroundColor: Color(0xff159deb)),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.43,
                    height: 55,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    child: ElevatedButton(
                      onPressed: () {
                        returnScan().catchError(() {
                          _showDialog(context);
                        });
                        refreshTools();
                      },
                      child: Text(
                        'RETURN',
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(backgroundColor: Color(0xff159deb)),
                    ),
                  )
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
                                )),
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
                      onRefresh: () {
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
}

//  ButtonTheme( //This is for barcode scanner new
//     minWidth: MediaQuery.of(context).size.width * 0.43,
//     height: 55,
//     shape: RoundedRectangleBorder(
//         borderRadius:
//          BorderRadius.circular(7.0)),
//     child: ElevatedButton(
//       onPressed: () {
//         returnScan().catchError(() {
//           _showDialog(context);
//         });
//         refreshTools();
//       },
//       child: Text(
//         'RETURN',
//         style: GoogleFonts.rubik(
//           fontWeight: FontWeight.bold,
//           fontSize: 20.0,
//           color: Colors.white,
//         ),
//       ),
//       style: ElevatedButton.styleFrom(backgroundColor: Color(0xff159deb)),
//     ),
//   )

// Container(
//       margin: EdgeInsets.only(left: 12, top: 50, right: 12, bottom: 0),
//       width: 400,
//       height: MediaQuery.of(context).size.height * 0.63,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         color: Color(0xff3a3d41),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 RichText(
//                   text: TextSpan(
//                     children: <TextSpan>[
//                       TextSpan(
//                           text: 'Checkout ',
//                           style: GoogleFonts.rubik(
//                             color: Colors.white,
//                             fontSize: 25.0,
//                           )
//                       )
//                     ]
//                   )
//                 ) 
//               ] 
//             )
//           ]     
//         )  
//       )
// )  