import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPart extends StatelessWidget {
  const AddPart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color background = Color(0xff26292c);
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "ADD PART",
          style: GoogleFonts.rubik(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xff159deb),
      ),
      body: Text("add part u gummy bear"),
    );
  }
}
