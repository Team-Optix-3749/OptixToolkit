import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:OptixToolkit/ui/tools/ToolStatus.dart';
import 'package:OptixToolkit/services/NavigationService.dart';
import 'package:OptixToolkit/services/database.dart';

import 'ToolReserve.dart';

typedef void RefreshFunction();

class ToolCard extends StatelessWidget {
  final List<Tool> tools;
  final String category;
  final RefreshFunction refreshTools;
  const ToolCard({Key? key, required this.tools, required this.category, required this.refreshTools})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dots_list = tools
        .map((tool) => ToolStatus(status: tool.status))
        .toList()
        .reversed
        .toList();

    return GestureDetector(
      onTap: () {
        NavigationService.goToAndThen(
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  ToolReserve(category: category, tools: tools, key: null,),
            ), (value) {
          refreshTools();
        });
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
                          text: "${category}",
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
              Row(children: dots_list),
            ],
          ),
        ),
      ),
    );
  }
}
