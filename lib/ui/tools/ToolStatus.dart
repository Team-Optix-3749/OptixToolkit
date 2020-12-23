import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToolStatus extends StatelessWidget {
  const ToolStatus({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color green = Color(0xff15ee07);
    final Color yellow = Color(0xffebe712);
    final Color red = Color(0xffd5212c);

    final Map<String, TextStyle> statusColor = {
      "notInUse": GoogleFonts.rubik(
        color: green,
        fontWeight: FontWeight.bold,
        fontSize: 40.0,
      ),
      "reserved": GoogleFonts.rubik(
        color: yellow,
        fontWeight: FontWeight.bold,
        fontSize: 40.0,
      ),
      "outOfService": GoogleFonts.rubik(
        color: red,
        fontWeight: FontWeight.bold,
        fontSize: 40.0,
      ),
    };

    return Container(
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.rubik(color: Colors.white, fontSize: 22.0),
          children: <TextSpan>[
            TextSpan(
              text: "· ",
              style: TextStyle(
                color: Color(0xff159deb),
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
