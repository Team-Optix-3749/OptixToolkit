// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

import 'ToolReserveItem.dart';

class ToolReserve extends StatefulWidget {
  ToolReserve({Key key}) : super(key: key);

  @override
  _ToolReserveState createState() => _ToolReserveState();
}

class _ToolReserveState extends State<ToolReserve> {
  final partNameController = TextEditingController();
  final partLinkController = TextEditingController();
  final partDescriptionController = TextEditingController();
  double priority = 0;

  final Color background = Color(0xff26292c);
  final Color gray = Color(0xff3A3D41);
  final Color subtleGray = Color(0xffcccccc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "RESERVE TOOL",
          style: GoogleFonts.rubik(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xff159deb),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 12, top: 20, right: 12, bottom: 0),
        width: 400,
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0xff3a3d41),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Tool ',
                            style: GoogleFonts.rubik(
                              color: Colors.white,
                              fontSize: 25.0,
                            )),
                        TextSpan(
                          text: 'Reservations',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView(
                  children: [ToolReserveItem()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
