import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:OptixToolkit/services/NavigationService.dart';
import 'package:OptixToolkit/services/database.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ToolReserveItem extends StatelessWidget {
  final Tool tool;
  const ToolReserveItem({Key key, this.tool}) : super(key: key);

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
            Column(
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
                            fontSize: 25.0,
                          ),
                        ),
                      ]),
                ),
                RichText(
                  text: TextSpan(
                    style:
                        GoogleFonts.rubik(color: Colors.white, fontSize: 20.0),
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
                      );
                      print("Result of the request: " + result.toString());
                      if (result) {
                        NavigationService.pop();
                      }
                    },
                    child: Text(
                      'RESERVE',
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
