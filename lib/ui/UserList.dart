// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:OptixToolkit/services/NavigationService.dart';
import 'package:OptixToolkit/services/database.dart';

class UserList extends StatefulWidget {
  UserList({Key key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
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
                  height: MediaQuery.of(context).size.height * 0.63,
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
                        Container(
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
                                            color: Colors.white,
                                            fontSize: 10.0),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Raadwan Masum",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    ButtonTheme(
                                      minWidth: 100,
                                      height: 40,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                      ),
                                      child: RaisedButton(
                                        onPressed: () async {},
                                        child: Text(
                                          "Remove",
                                          style: GoogleFonts.rubik(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        color: Color(0xffd5212c),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
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
    );
  }
}
