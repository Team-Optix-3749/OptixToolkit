import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPart extends StatelessWidget {
  const AddPart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("bruh",
                style: GoogleFonts.rubik(fontWeight: FontWeight.bold))),
        backgroundColor: Color(0xff159deb),
      ),
      body: Text("add part u gummy bear"),
    );
  }
}
