import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:OptixToolkit/services/firebase.dart';

class homePage extends StatelessWidget {
  homePage({Key key, this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      StreamProvider<User>.value(
          value: Database.readDocListener<User>(["users", uid], User()))
    ], child: homePage2());
  }
}

class homePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
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
                                    text: Provider.of<User>(context) == null
                                        ? ""
                                        : Provider.of<User>(context).name,
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
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: 12, top: 17, right: 12, bottom: 0),
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Color(0xff3a3d41),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                            const SizedBox(height: 15),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: 'Mill ',
                                                      style: GoogleFonts.rubik(
                                                        color:
                                                            Color(0xff159deb),
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                      text: '2pm-2:30pm ',
                                                      style: GoogleFonts.rubik(
                                                        color: Colors.white,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: 'Drill ',
                                                      style: GoogleFonts.rubik(
                                                        color:
                                                            Color(0xff159deb),
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                      text: '2pm-2:30pm ',
                                                      style: GoogleFonts.rubik(
                                                        color: Colors.white,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: 'Bandsaw ',
                                                      style: GoogleFonts.rubik(
                                                        color:
                                                            Color(0xff159deb),
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                      text: '2pm-2:30pm ',
                                                      style: GoogleFonts.rubik(
                                                        color: Colors.white,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: 'ChopSaw ',
                                                      style: GoogleFonts.rubik(
                                                        color:
                                                            Color(0xff159deb),
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                      text: '2pm-2:30pm ',
                                                      style: GoogleFonts.rubik(
                                                        color: Colors.white,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ]),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ButtonTheme(
                                      minWidth: 160,
                                      height: 40,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0)),
                                      child: RaisedButton(
                                        onPressed: () {},
                                        child: Text('RESERVE A TOOL',
                                            style: GoogleFonts.rubik(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                        color: Color(0xff159deb),
                                      ),
                                    ),
                                    ButtonTheme(
                                      minWidth: 160,
                                      height: 40,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0)),
                                      child: RaisedButton(
                                        onPressed: () {},
                                        child: Text('CHECKOUT A TOOL',
                                            style: GoogleFonts.rubik(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                        color: Color(0xff159deb),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: 12, top: 17, right: 12, bottom: 17),
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Color(0xff3a3d41),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                            Column(
                              children: [
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
                                            MediaQuery.of(context).size.width -
                                                100,
                                        animation: true,
                                        lineHeight: 30.0,
                                        animationDuration: 1000,
                                        backgroundColor: Color(0xff26292c),
                                        percent: 0.75,
                                        center: RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: 'Falcon 500: ',
                                                  style: GoogleFonts.rubik(
                                                    color: Colors.white,
                                                    fontSize: 15.0,
                                                  )),
                                              TextSpan(
                                                text: 'Shipped',
                                                style: GoogleFonts.rubik(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        progressColor: Color(0xff159deb),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}
