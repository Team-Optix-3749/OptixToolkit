import 'package:OptixToolkit/screens/subwidgets/PartModal.dart';
import 'package:OptixToolkit/services/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PartCard extends StatelessWidget {
  final Part part;
  const PartCard({Key key, this.part}) : super(key: key);

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return PartModal(part: part);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color green = Color(0xff3ce887);
    final Color yellow = Color(0xffe6d040);
    final Color orange = Colors.orange;
    final Color red = Colors.red;
    final Color pink = Colors.pink;

    final Map<String, TextStyle> styleMap = {
      "Arrived": GoogleFonts.rubik(color: green, fontWeight: FontWeight.bold),
      "Shipped": GoogleFonts.rubik(color: yellow, fontWeight: FontWeight.bold),
      "Ordered": GoogleFonts.rubik(color: orange, fontWeight: FontWeight.bold),
      "Failure": GoogleFonts.rubik(color: pink, fontWeight: FontWeight.bold),
    };

    return new GestureDetector(
      onTap: () {
        _showMyDialog(context);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        width: 330,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0xff26292c),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.rubik(
                          color: Colors.white, fontSize: 20.0),
                      children: <TextSpan>[
                        TextSpan(
                          text: "${part.displayName}\n",
                        ),
                        TextSpan(
                          text: "${part.name}",
                          style: TextStyle(
                            color: Color(0xff159deb),
                            fontWeight: FontWeight.bold,
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
                      style: GoogleFonts.rubik(
                          color: Colors.white, fontSize: 22.0),
                      children: <TextSpan>[
                        TextSpan(
                          text: part.status,
                          style: styleMap[part.status],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}