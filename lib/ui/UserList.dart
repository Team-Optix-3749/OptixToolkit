// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:OptixToolkit/services/NavigationService.dart';
import 'package:OptixToolkit/services/database.dart';

import 'Loading.dart';
import 'UserCard.dart';

class UserList extends StatefulWidget {
  UserList({Key key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final Color background = Color(0xff26292c);
  final Color gray = Color(0xff3A3D41);
  final Color subtleGray = Color(0xffcccccc);

  List<UserCard> users = null;
  String err = null;
  bool called = false;

  @override
  Widget build(BuildContext context) {
    if (!called) {
      Database.getUsers(Provider.of<IdTokenResult>(context)).then((v) {
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
                  height: MediaQuery.of(context).size.height * 0.80,
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
                              child: ListView(children: users),
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
          NavigationService.pop();
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
