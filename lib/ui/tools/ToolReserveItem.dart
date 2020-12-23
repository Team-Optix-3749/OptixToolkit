import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:OptixToolkit/services/NavigationService.dart';

class ToolReserveItem extends StatelessWidget {
  const ToolReserveItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color green = Color(0xff15ee07);
    final Color yellow = Color(0xffebe712);
    final Color red = Color(0xffd5212c);

    final Map<String, TextStyle> statusColor = {
      "notInUse": GoogleFonts.rubik(
        color: green,
        fontSize: 15.0,
      ),
      "reserved": GoogleFonts.rubik(
        color: yellow,
        fontSize: 15.0,
      ),
      "outOfService": GoogleFonts.rubik(
        color: red,
        fontSize: 15.0,
      ),
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
                    style:
                        GoogleFonts.rubik(color: Colors.white, fontSize: 20.0),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Band Saw 1",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style:
                        GoogleFonts.rubik(color: Colors.white, fontSize: 20.0),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Not in Use",
                        style: TextStyle(
                          color: green,
                          fontSize: 20.0,
                        ),
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
                    onPressed: () {
                      NavigationService.pop();
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
