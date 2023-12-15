// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:OptixToolkit/services/NavigationService.dart';
import 'package:OptixToolkit/services/database.dart';

class ToolAdd extends StatefulWidget {
  ToolAdd({Key? key}) : super(key: key);

  @override
  _ToolAddState createState() => _ToolAddState();
}

class _ToolAddState extends State<ToolAdd> {
  final partNameController = TextEditingController();
  final partLinkController = TextEditingController();
  final trackingNumberController = TextEditingController();
  final partDescriptionController = TextEditingController();
  String dropdownValue = "Type of Tool";
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
          "ADD TOOL",
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
                          text: 'Tool',
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
                            if (value!.isEmpty) {
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
                            hintText: 'Tool Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0)),
                            hintStyle: GoogleFonts.rubik(color: subtleGray),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
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
                              if (value == "Type of Tool")
                                return "Type of Tool";
                              return null;
                            },
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              }
                            },
                            items: <String>[
                              'Type of Tool',
                              'Drill',
                              'Jig Saw',
                              'Circular Saw',
                              'Drill press',
                              'Mill',
                              'Chop Saw',
                              'Driver',
                              'Angle Grinder',
                              'Band Saw'
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
                      const SizedBox(height: 5),
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
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      print("Handling on pressed");
                                      var result = await Database.addTool(
                                          Provider.of<firebase.IdTokenResult>(context,
                                              listen: false),
                                          partNameController.text,
                                          dropdownValue,
                                          context);
                                      print("Result of the request below: ");
                                      print(result);
                                      if (result) {
                                        NavigationService.pop();
                                        NavigationService.pop();
                                      }
                                    }
                                  },
                                  child: Text('ADD',
                                      style: GoogleFonts.rubik(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xff159deb)),
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
