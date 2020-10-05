// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class homePage extends StatelessWidget {
  homePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return homePage2();
    /*MultiProvider(
        providers: [
          StreamProvider<User>.value(
          value: Database.readDocListener<User>(["users", user.uid], User()))
        ],
        child: );*/
  }
}

class homePage2 extends StatelessWidget {
  homePage2({Key key}) : super(key: key);

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
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 15.0,
                                    right: 12.0,
                                    left: 12.0,
                                    bottom: 0.0,
                                  ),
                                  child: LinearPercentIndicator(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    animation: true,
                                    lineHeight: 30.0,
                                    animationDuration: 1000,
                                    backgroundColor: Color(0xff26292c),
                                    percent: 1,
                                    center: RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Limelight: ',
                                            style: GoogleFonts.rubik(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Arrived',
                                            style: GoogleFonts.rubik(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Colors.lightGreenAccent[400],
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Color(0xff159deb),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 15.0,
                                    right: 17.0,
                                    left: 17.0,
                                    bottom: 0.0,
                                  ),
                                  child: LinearPercentIndicator(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    animation: true,
                                    lineHeight: 30.0,
                                    animationDuration: 1000,
                                    backgroundColor: Color(0xff26292c),
                                    percent: 0.75,
                                    center: RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Spark Max: ',
                                            style: GoogleFonts.rubik(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Shipped',
                                            style: GoogleFonts.rubik(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.yellowAccent,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Color(0xff159deb),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 15.0,
                                    right: 17.0,
                                    left: 17.0,
                                    bottom: 0.0,
                                  ),
                                  child: LinearPercentIndicator(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    animation: true,
                                    lineHeight: 30.0,
                                    animationDuration: 1000,
                                    backgroundColor: Color(0xff26292c),
                                    percent: 0.40,
                                    center: RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Fairlane Wheel: ',
                                            style: GoogleFonts.rubik(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Ordered',
                                            style: GoogleFonts.rubik(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Color(0xff159deb),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 15.0,
                                    right: 17.0,
                                    left: 17.0,
                                    bottom: 0.0,
                                  ),
                                  child: LinearPercentIndicator(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    animation: true,
                                    lineHeight: 30.0,
                                    animationDuration: 1000,
                                    backgroundColor: Color(0xff26292c),
                                    percent: 0,
                                    center: RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Falcon 500: ',
                                            style: GoogleFonts.rubik(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Not Ordered',
                                            style: GoogleFonts.rubik(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Color(0xff159deb),
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
