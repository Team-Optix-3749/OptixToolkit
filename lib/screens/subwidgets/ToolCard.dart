import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:OptixToolkit/services/database.dart';

class ToolCard extends StatelessWidget {
  const ToolCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        text: "Band Saw",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
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
                    style:
                        GoogleFonts.rubik(color: Colors.white, fontSize: 22.0),
                    children: <TextSpan>[
                      TextSpan(
                        text: "·",
                        style: TextStyle(
                          color: Color(0xff159deb),
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0,
                        ),
                      ),
                    ],
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
