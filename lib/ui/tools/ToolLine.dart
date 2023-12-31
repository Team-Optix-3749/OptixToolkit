import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:OptixToolkit/services/database.dart';

class ToolLine extends StatelessWidget {
  final Tool tool;
  final String status;
  const ToolLine({Key? key, required this.tool, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color green = Color(0xff15ee07);
    final Color yellow = Color(0xffebe712);
    final Color red = Color(0xffd5212c);
    final Color orange = Color(0xffff9415);

    final Map<String, String> statusMessage = {
      "notInUse": "Not In Use",
      "inUse": "In Use",
      "reserved": "Reserved",
      "outOfService": "Out of Service",
    };

    final Map<String, TextStyle> statusColor = {
      "notInUse": GoogleFonts.rubik(
        color: green,
        fontWeight: FontWeight.bold,
        fontSize: 21.0,
      ),
      "inUse": GoogleFonts.rubik(
        color: orange,
        fontWeight: FontWeight.bold,
        fontSize: 21.0,
      ),
      "reserved": GoogleFonts.rubik(
        color: yellow,
        fontWeight: FontWeight.bold,
        fontSize: 21.0,
      ),
      "outOfService": GoogleFonts.rubik(
        color: red,
        fontWeight: FontWeight.bold,
        fontSize: 21.0,
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
                      text: "${tool.name}",
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
                      text: statusMessage[status],
                      style: statusColor[status],
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
