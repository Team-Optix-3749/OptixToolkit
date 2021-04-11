import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:OptixToolkit/services/NavigationService.dart';
import 'package:OptixToolkit/services/database.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ToolReserveItem extends StatelessWidget {
  final Tool tool;
  const ToolReserveItem({Key key, this.tool}) : super(key: key);

  Future<void> _showToolService(BuildContext context) async {
    Widget doneButton = FlatButton(
      child: Text(
        "Done",
        style: GoogleFonts.rubik(
          fontWeight: FontWeight.bold,
          color: Color(0xff159deb),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            title: Text(
              'Change Tool Status',
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.bold,
                color: Color(0xff159deb),
              ),
            ),
            backgroundColor: Color(0xff26292c),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: tool.reservations
                          .map(
                            (user) => TextSpan(
                              text: '${user}\n',
                              style: GoogleFonts.rubik(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              // editButton,
              doneButton,
            ],
          ),
        );
      },
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    Widget doneButton = FlatButton(
      child: Text(
        "Done",
        style: GoogleFonts.rubik(
          fontWeight: FontWeight.bold,
          color: Color(0xff159deb),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            title: Text(
              'Reservations',
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.bold,
                color: Color(0xff159deb),
              ),
            ),
            backgroundColor: Color(0xff26292c),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: tool.reservations
                          .map(
                            (user) => TextSpan(
                              text: '${user}\n',
                              style: GoogleFonts.rubik(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              // editButton,
              doneButton,
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color green = Color(0xff15ee07);
    final Color yellow = Color(0xffebe712);
    final Color red = Color(0xffd5212c);
    final Color orange = Color(0xffff9415);

    final Map<String, TextStyle> statusColor = {
      "notInUse": GoogleFonts.rubik(
        color: green,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      "inUse": GoogleFonts.rubik(
        color: orange,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      "reserved": GoogleFonts.rubik(
        color: yellow,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      "outOfService": GoogleFonts.rubik(
        color: red,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    };

    final Map<String, String> statusDisplayMap = {
      "notInUse": "Not In Use",
      "inUse": "In Use",
      "reserved": "Reserved",
      "outOfService": "Out of Service"
    };

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: 330,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xff26292c),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _showMyDialog(context);
              },
              onLongPress: () => {_showToolService(context)},
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                        style: GoogleFonts.rubik(
                            color: Colors.white, fontSize: 20.0),
                        children: [
                          TextSpan(
                            text: "${tool.name}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                            ),
                          ),
                        ]),
                  ),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.rubik(
                          color: Colors.white, fontSize: 20.0),
                      children: <TextSpan>[
                        TextSpan(
                          text: "${statusDisplayMap[tool.status]}",
                          style: statusColor[tool.status],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                ButtonTheme(
                  minWidth: 120,
                  height: 55,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: RaisedButton(
                    onPressed: () async {
                      print("Handling on pressed");
                      print("Tool Name: " + tool.name);
                      print("Tool Status: " + tool.status);
                      var result = await Database.reserveTool(
                          Provider.of<IdTokenResult>(context, listen: false),
                          Provider.of<FirebaseUser>(context, listen: false),
                          tool.name,
                          context);
                      print("Result of the request: " + result.toString());
                      if (result) {
                        NavigationService.pop();
                      }
                    },
                    child: Text(
                      tool.reservations.contains(
                              Provider.of<FirebaseUser>(context).displayName)
                          ? "UNRESERVE"
                          : "RESERVE",
                      style: GoogleFonts.rubik(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    color: Color(0xff159deb),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
