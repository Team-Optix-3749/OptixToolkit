// Flutter imports:
import 'package:OptixToolkit/services/NavigationService.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:OptixToolkit/services/database.dart';
import 'package:OptixToolkit/ui/tools/ToolAdd.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'ToolReserveItem.dart';

class ToolReserve extends StatelessWidget {
  final partNameController = TextEditingController();
  final partLinkController = TextEditingController();
  final partDescriptionController = TextEditingController();
  final List<Tool> tools;
  final String category;

  ToolReserve({Key? key, required this.tools, required this.category}) : super(key: key);

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
                  children:
                      tools.map((tool) => ToolReserveItem(tool: tool)).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton:
          (Provider.of<firebase.IdTokenResult>(context).claims?['admin'] == true)
              ? FloatingActionButton(
                  onPressed: () {
                    NavigationService.goTo(
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            ToolAdd(key: null,),
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                  backgroundColor: Color(0xff159deb),
                )
              : null,
    );
  }
}
