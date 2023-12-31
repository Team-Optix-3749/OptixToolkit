// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:OptixToolkit/services/NavigationService.dart';
import 'package:OptixToolkit/services/database.dart';

import 'Loading.dart';
import 'UserCard.dart';

class UserList extends StatefulWidget {
  UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final Color background = Color(0xff26292c);
  final Color gray = Color(0xff3A3D41);
  final Color subtleGray = Color(0xffcccccc);

  final partNameController = TextEditingController();
  final partLinkController = TextEditingController();
  String dropdownValue = "Select a Carrier";
  double priority = 0;

  final _formKey = GlobalKey<FormState>();

  List<UserCard>? users = null;
  String? err = null;
  bool called = false;

  Future<void> _showToolService(BuildContext context) async {
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: GoogleFonts.rubik(
          fontWeight: FontWeight.bold,
          color: Color(0xff159deb),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        bool _checked = false;
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            child: AlertDialog(
              title: Text(
                'Add User',
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff159deb),
                ),
              ),
              backgroundColor: Color(0xff26292c),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
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
                                  return 'Enter User Name';
                                }
                                return null;
                              },
                              style: GoogleFonts.rubik(color: Colors.white),
                              textAlign: TextAlign.center,
                              controller: partNameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: gray,
                                hintText: 'User Name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0)),
                                hintStyle: GoogleFonts.rubik(color: subtleGray),
                              ),
                            ),
                          ),
                          Container(
                            width: 300,
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter User Email Address';
                                }
                                return null;
                              },
                              style: GoogleFonts.rubik(color: Colors.white),
                              textAlign: TextAlign.center,
                              controller: partLinkController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: gray,
                                hintText: 'User Email Address',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0)),
                                hintStyle: GoogleFonts.rubik(color: subtleGray),
                              ),
                            ),
                          ),
                          CheckboxListTile(
                            title: const Text(
                              'Admin',
                              style: TextStyle(color: Colors.white),
                            ),
                            autofocus: false,
                            activeColor: Color(0xff159deb),
                            checkColor: Colors.white,
                            selected: _checked,
                            value: _checked,
                            onChanged: (bool? value) {
                              setState(() {
                                _checked = value ?? false;
                              });
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 0),
                            width: 300,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  ButtonTheme(
                                    minWidth: 190,
                                    height: 45,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0)),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          print("Handling on pressed");
                                          var result = await Database.addUser(
                                              Provider.of<firebase.IdTokenResult>(
                                                  context,
                                                  listen: false),
                                              partNameController.text,
                                              partLinkController.text,
                                              _checked,
                                              context);
                                          print(
                                              "Result of the request below: ");
                                          print(result);
                                          if (result) {
                                            NavigationService.pop();
                                          }
                                        }
                                      },
                                      child: Text(
                                        'ADD USER',
                                        style: GoogleFonts.rubik(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0,
                                            color: Colors.white),
                                      ),
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
              actions: [
                // (!!Provider.of<firebase.IdTokenResult>(context).claims['admin'])
                //     ? removeButton
                //     : null,
                cancelButton,
              ],
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!called) {
      Database.getUsers(Provider.of<firebase.IdTokenResult>(context)).then((v) {
        setState(() {
          users = v.map((u) => UserCard(user: u)).toList();
        });
      }).catchError((e) {
        setState(() {
          err = e;
        });
      });
    }
    called = true;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "USER MANAGEMENT",
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
                  margin:
                      EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
                  width: 400,
                  height: MediaQuery.of(context).size.height * 0.70,
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
                                      text: 'User ',
                                      style: GoogleFonts.rubik(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                      )),
                                  TextSpan(
                                    text: 'List',
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
                        if (err != null)
                          Text('Error: ${err}')
                        else if (users == null)
                          Loading()
                        else
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {},
                              child: ListView(children: users??[]),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // NavigationService.pop();
          _showToolService(context);
          // NavigationService.goTo(
          //   PageRouteBuilder(
          //     pageBuilder: (context, animation1, animation2) => ToolAdd(),
          //   ),
          // );
        },
        child: const Icon(Icons.add),
        backgroundColor: Color(0xff159deb),
      ),
    );
  }
}
