
import 'package:flutter/material.dart';
import 'package:OptixToolkit/services/database.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

class PartLine extends StatelessWidget {
  final Part part;
  const PartLine({Key key, this.part}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color green = Color(0xff3ce887);
    final Color yellow = Color(0xffe6d040);
    final Color orange = Colors.orange;
    final Color red = Colors.red;
    final Color pink = Colors.pink;

    final Map<String, TextStyle> styleMap = {
      "Arrived": GoogleFonts.rubik(
        color: green,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
      "Shipped": GoogleFonts.rubik(
        color: yellow,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
      "Ordered": GoogleFonts.rubik(
        color: orange,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
      "Failure": GoogleFonts.rubik(
        color: pink,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
    };

    final Map<String,double> percentMap = {
      "Arrived": 1.0,
      "Shipped": 0.75,
      "Ordered": 0.4,
      "Failure": 0.0,
    };

    return Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 15.0,
              right: 17.0,
              left: 17.0,
              bottom: 0.0,
            ),
            child: LinearPercentIndicator(
              width:
                  MediaQuery.of(context).size.width - 100,
              animation: true,
              lineHeight: 30.0,
              animationDuration: 1000,
              backgroundColor: Color(0xff26292c),
              percent: percentMap[part.status],
              center: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: '${part.name}: ',
                      style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                    TextSpan(
                      text: part.status,
                      style: styleMap[part.status]
                    ),
                  ],
                ),
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Color(0xff159deb),
            ),
          ),
        ],
    );
  }
}