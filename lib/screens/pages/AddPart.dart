import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPart extends StatefulWidget {
  AddPart({Key key}) : super(key: key);

  @override
  _AddPartState createState() => _AddPartState();
}

class _AddPartState extends State<AddPart> {
  final partNameController = TextEditingController();
  final partLinkController = TextEditingController();
  final partDescriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
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
          "REQUEST PART",
          style: GoogleFonts.rubik(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xff159deb),
      ),
      body: Center(
        child: Container(
          child: Container(
            margin: EdgeInsets.only(top: 17, bottom: 17),
            child: Column(
              children: [
                Container(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Request a ',
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                        ),
                        TextSpan(
                          text: 'Part',
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Form(
                  child: Column(
                    children: [
                      Container(
                        width: 300,
                        margin: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Part Name';
                            }
                            return null;
                          },
                          obscureText: true,
                          style: GoogleFonts.rubik(color: Colors.white),
                          textAlign: TextAlign.center,
                          controller: partNameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: gray,
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0)),
                            hintStyle: GoogleFonts.rubik(color: subtleGray),
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        margin: EdgeInsets.only(top: 17),
                        child: TextFormField(
                          validator: (value) {
                            if (value.length < 8 &&
                                !((value.substring(0, 8) != "https://") ||
                                    (value.substring(0, 8) != "http://"))) {
                              return 'Enter Valid Link (with http(s))';
                            }
                            return null;
                          },
                          obscureText: true,
                          style: GoogleFonts.rubik(color: Colors.white),
                          textAlign: TextAlign.center,
                          controller: partLinkController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: gray,
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0)),
                            hintStyle: GoogleFonts.rubik(color: subtleGray),
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        margin: EdgeInsets.only(top: 17),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter a Part Link';
                            }
                            return null;
                          },
                          obscureText: true,
                          style: GoogleFonts.rubik(color: Colors.white),
                          textAlign: TextAlign.start,
                          controller: partNameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: gray,
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0)),
                            hintStyle: GoogleFonts.rubik(color: subtleGray),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
