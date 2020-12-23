import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToolLine extends StatelessWidget {
  const ToolLine({Key key}) : super(key: key);

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Angle Grinder ',
                      style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: 21.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Not in Use',
                      style: GoogleFonts.rubik(
                        color: green,
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
