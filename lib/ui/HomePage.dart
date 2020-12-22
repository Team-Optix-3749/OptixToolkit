// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:OptixToolkit/services/database.dart';
import 'package:OptixToolkit/ui/Loading.dart';
import 'package:OptixToolkit/screens/subwidgets/PartLine.dart';

class homePage extends StatelessWidget {
  homePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<IdTokenResult>(
      future: Provider.of<FirebaseUser>(context, listen: false).getIdToken(),
      builder: (context, idToken) {
        switch (idToken.connectionState) {
          case ConnectionState.waiting:
            return Loading();
          default:
            if (idToken.hasError)
              return Text('Error: ${idToken.error}');
            else
              return FutureBuilder<List<Part>>(
                future: Database.getParts(idToken.data),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Loading();
                    default:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      else
                        return homePage2(
                          parts: snapshot.data,
                        );
                  }
                },
              );
        }
      },
    );
  }
}

class homePage2 extends StatelessWidget {
  final List<Part> parts;
  homePage2({Key key, this.parts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xff3a3d41),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Hey there, ',
                                    style: GoogleFonts.rubik(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                    )),
                                TextSpan(
                                  text: Provider.of<FirebaseUser>(context)
                                      .displayName
                                      .split(" ")[0],
                                  style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 25.0,
                                  ),
                                ),
                                TextSpan(
                                  text: '!',
                                  style: GoogleFonts.rubik(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
                width: 400,
                height: MediaQuery.of(context).size.height * 0.25,
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
                                    text: 'Upcoming ',
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
                      const SizedBox(height: 5),
                      Expanded(
                        child: ListView(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Angle Grinder ',
                                              style: GoogleFonts.rubik(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '12:30pm - 12:40pm ',
                                              style: GoogleFonts.rubik(
                                                color: Color(0xff159deb),
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Mill ',
                                              style: GoogleFonts.rubik(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '1:30pm - 1:40pm ',
                                              style: GoogleFonts.rubik(
                                                color: Color(0xff159deb),
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Band Saw ',
                                              style: GoogleFonts.rubik(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '2:30pm - 2:40pm ',
                                              style: GoogleFonts.rubik(
                                                color: Color(0xff159deb),
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Drill ',
                                              style: GoogleFonts.rubik(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '3:30pm - 3:40pm ',
                                              style: GoogleFonts.rubik(
                                                color: Color(0xff159deb),
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Chop Saw ',
                                              style: GoogleFonts.rubik(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '5:30pm - 5:40pm ',
                                              style: GoogleFonts.rubik(
                                                color: Color(0xff159deb),
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
                width: 400,
                height: MediaQuery.of(context).size.height * 0.35,
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
                                    text: 'Incoming ',
                                    style: GoogleFonts.rubik(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                    )),
                                TextSpan(
                                  text: 'Parts',
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
                      Expanded(
                        child: ListView(
                          children: parts
                              .map<Widget>((part) => PartLine(part: part))
                              .toList()
                              .reversed
                              .toList()
                              .sublist(0, 4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
