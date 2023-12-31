import 'package:flutter/material.dart';
import 'package:OptixToolkit/services/database.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

class PartLine extends StatelessWidget {
  final Part part;
  const PartLine({Key? key, required this.part}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color green = Color(0xff15ee07);
    final Color yellow = Color(0xffebe712);
    final Color red = Color(0xffd5212c);
    final Color orange = Color(0xffff9415);

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
        color: red,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
    };

    final Map<String, double> percentMap = {
      "Arrived": 1.0,
      "Shipped": 0.75,
      "Ordered": 0.4,
      "Failure": 0.000000000000001,
    };

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 15.0,
            right: 10.0,
            left: 10.0,
            bottom: 0.0,
          ),
          child: LinearPercentIndicator(
            width: MediaQuery.of(context).size.width - 80,
            animation: true,
            lineHeight: 30.0,
            animationDuration: 1000,
            backgroundColor: Color(0xff26292c),
            percent: percentMap[part.status]!,
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
                  TextSpan(text: part.status, style: styleMap[part.status]),
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
