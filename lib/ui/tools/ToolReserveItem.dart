import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:OptixToolkit/ui/tools/ToolsPage.dart';
import 'package:OptixToolkit/services/NavigationService.dart';

import 'ToolReserve.dart';
import 'ToolsPage.dart';

class ToolReserveItem extends StatelessWidget {
  const ToolReserveItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationService.goTo(
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => ToolReserve(),
          ),
        );
      },
      child: Container(
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
                      style: GoogleFonts.rubik(
                          color: Colors.white, fontSize: 20.0),
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
              Row(
                children: [
                  RaisedButton(
                    onPressed: () {
                      NavigationService.goTo(
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              toolsPage(),
                        ),
                      );
                    },
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
