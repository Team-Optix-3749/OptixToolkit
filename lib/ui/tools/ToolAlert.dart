// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import 'package:OptixToolkit/services/database.dart';

class ToolAlert extends StatelessWidget {
  final String alert;
  const ToolAlert({Key key, this.alert}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color green = Color(0xff15ee07);
    final Color yellow = Color(0xffebe712);
    final Color red = Color(0xffd5212c);
    final Color orange = Color(0xffff9415);

    final Map<String, TextStyle> styleMap = {
      "Arrived": GoogleFonts.rubik(
          color: green, fontWeight: FontWeight.bold, fontSize: 18.0),
      "Shipped": GoogleFonts.rubik(
        color: yellow,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
      "Ordered": GoogleFonts.rubik(
        color: orange,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
      "Failure": GoogleFonts.rubik(
        color: red,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
    };
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

    return AlertDialog(
      title: Text(
        'Critical Error',
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
                children: <TextSpan>[
                  TextSpan(
                    text: '${alert}',
                    style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        // editButton,
        doneButton,
      ],
    );
  }
}
