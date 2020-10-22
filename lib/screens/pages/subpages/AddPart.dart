// Flutter imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

import 'package:OptixToolkit/services/database.dart';
import 'package:provider/provider.dart';

class AddPart extends StatefulWidget {
  AddPart({Key key}) : super(key: key);

  @override
  _AddPartState createState() => _AddPartState();
}

class _AddPartState extends State<AddPart> {
  final partNameController = TextEditingController();
  final partLinkController = TextEditingController();
  final trackingNumberController = TextEditingController();
  final partDescriptionController = TextEditingController();
  String dropdownValue = "Select a Carrier";
  double priority = 0;

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
          "ADD PART",
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
                          text: 'Add a ',
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
                              return 'Enter Tracking Number';
                            }
                            return null;
                          },
                          style: GoogleFonts.rubik(color: Colors.white),
                          textAlign: TextAlign.center,
                          controller: trackingNumberController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: gray,
                            hintText: 'Tracking Number',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0)),
                            hintStyle: GoogleFonts.rubik(color: subtleGray),
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: Color(0xff3a3d41),
                          ),
                          child: DropdownButtonFormField<String>(
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: GoogleFonts.rubik(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                            validator: (value) {
                              if (value == "Select a Tool")
                                return "Select a Tool";
                              return null;
                            },
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            items: <String>[
                              'Select a Carrier',
                              'Amazon',
                              'FedEx',
                              'UPS',
                              'USPS',
                            ].map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child:
                                      Text(value, textAlign: TextAlign.center),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Priority',
                                style: GoogleFonts.rubik(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 325,
                        margin: EdgeInsets.only(top: 3),
                        child: Slider(
                          value: priority,
                          onChanged: (value) =>
                              setState(() => priority = value),
                          divisions: 5,
                          label: "$priority",
                          min: 0,
                          max: 5,
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
                                    print("Handling on pressed");
                                    var result = await Database.addPart(
                                        await Provider.of<FirebaseUser>(context,
                                                listen: false)
                                            .getIdToken(),
                                        Provider.of<FirebaseUser>(context,
                                            listen: false),
                                        partNameController.text,
                                        partLinkController.text,
                                        trackingNumberController.text,
                                        dropdownValue,
                                        '',
                                        priority);
                                    print("Result of the request below: ");
                                    print(result);
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
