// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// Project imports:
import 'package:OptixToolkit/services/NavigationService.dart';
import 'package:OptixToolkit/services/database.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:OptixToolkit/services/firebase.dart';

class PartReimburse extends StatefulWidget {
  PartReimburse({Key key}) : super(key: key);

  @override
  _PartReimburseState createState() => _PartReimburseState();
}

class _PartReimburseState extends State<PartReimburse> {
  final partNameController = TextEditingController();
  final partLinkController = TextEditingController();
  final mailingAddressController = TextEditingController();
  final partDescriptionController = TextEditingController();
  String dropdownValue = "Select a Carrier";
  double priority = 0;
  File _image;
  final picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  final Color background = Color(0xff26292c);
  final Color gray = Color(0xff3A3D41);
  final Color subtleGray = Color(0xffcccccc);

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print('image selected');
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "GET REIMBURSED",
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
                          text: 'Get ',
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                        ),
                        TextSpan(
                          text: 'Reimbursed',
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
                  key: _formKey,
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
                          style: GoogleFonts.rubik(color: Colors.white),
                          textAlign: TextAlign.center,
                          controller: partNameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: gray,
                            hintText: 'Part Name',
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
                          style: GoogleFonts.rubik(color: Colors.white),
                          textAlign: TextAlign.center,
                          controller: partLinkController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: gray,
                            hintText: 'Part Link',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0)),
                            hintStyle: GoogleFonts.rubik(color: subtleGray),
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        margin: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Mailing Address';
                            }
                            return null;
                          },
                          style: GoogleFonts.rubik(color: Colors.white),
                          textAlign: TextAlign.center,
                          controller: mailingAddressController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: gray,
                            hintText: 'Mailing Address',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0)),
                            hintStyle: GoogleFonts.rubik(color: subtleGray),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: 300,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ButtonTheme(
                                minWidth: 200,
                                height: 55,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0)),
                                child: RaisedButton(
                                  onPressed: () async {
                                    getImage();
                                  },
                                  child: Text('PICK IMAGE',
                                      style: GoogleFonts.rubik(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  color: Color(0xff159deb),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: 300,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ButtonTheme(
                                minWidth: 200,
                                height: 55,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0)),
                                child: RaisedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      print("Handling on pressed");
                                      var result = await Database.reimbursement(
                                          Provider.of<IdTokenResult>(context,
                                              listen: false),
                                          Provider.of<FirebaseUser>(context,
                                                  listen: false)
                                              .displayName,
                                          partNameController.text,
                                          partLinkController.text,
                                          mailingAddressController.text,
                                          await Auth.getImageUrl(
                                              _image,
                                              Provider.of<FirebaseUser>(context,
                                                  listen: false)),
                                          context);
                                      print("Result of the request below: ");
                                      print(result);
                                      if (result) {
                                        NavigationService.pop();
                                      }
                                    }
                                  },
                                  child: Text('ADD',
                                      style: GoogleFonts.rubik(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  color: Color(0xff159deb),
                                ),
                              ),
                            ],
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
