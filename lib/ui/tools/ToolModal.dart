// Flutter imports:
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:OptixToolkit/services/database.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

class ToolModal extends StatelessWidget {
  final Inventory inventory;
  const ToolModal({Key? key, required this.inventory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color blue = Color(0xff159deb);
    final Color green = Color(0xff15ee07);
    final Color yellow = Color(0xffebe712);
    final Color red = Color(0xffd5212c);
    final Color orange = Color(0xffff9415);

    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
    );

    Widget doneButton = TextButton(
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
        'Tool: ${inventory.name}',
        style: GoogleFonts.rubik(
          fontSize: 25.0,
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
                    text: 'Count: ${inventory.count}',
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            if (inventory.description != null)
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Description: ${inventory.description}',
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff159deb),
              ),
              onPressed: () async {},
              child: RichText(
                text: TextSpan(
                  text: 'Use Tool',
                  style: GoogleFonts.rubik(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        doneButton,
      ],
    );
  }
}
