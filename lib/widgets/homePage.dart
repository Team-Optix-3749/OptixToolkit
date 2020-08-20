import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class homePage extends StatefulWidget {
  homePage({Key key, this.name}) : super(key: key);

  final String name;

  @override
  _homePage createState() => _homePage();
}

class _homePage extends State<homePage> {
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
                          new RichText(
                            text: new TextSpan(
                              children: <TextSpan>[
                                new TextSpan(
                                    text: 'Hey there, ',
                                    style: GoogleFonts.rubik(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                    )),
                                new TextSpan(
                                  text: widget.name.split(" ")[0],
                                  style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 25.0,
                                  ),
                                ),
                                new TextSpan(
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
                              new RichText(
                                text: new TextSpan(
                                  children: <TextSpan>[
                                    new TextSpan(
                                        text: 'Upcoming ',
                                        style: GoogleFonts.rubik(
                                          color: Colors.white,
                                          fontSize: 25.0,
                                        )),
                                    new TextSpan(
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
                                            new RichText(
                                              text: new TextSpan(
                                                children: <TextSpan>[
                                                  new TextSpan(
                                                    text: 'Mill ',
                                                    style: GoogleFonts.rubik(
                                                      color: Color(0xff159deb),
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
                                            new RichText(
                                              text: new TextSpan(
                                                children: <TextSpan>[
                                                  new TextSpan(
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
                                            new RichText(
                                              text: new TextSpan(
                                                children: <TextSpan>[
                                                  new TextSpan(
                                                    text: 'Drill ',
                                                    style: GoogleFonts.rubik(
                                                      color: Color(0xff159deb),
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
                                            new RichText(
                                              text: new TextSpan(
                                                children: <TextSpan>[
                                                  new TextSpan(
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
                                            new RichText(
                                              text: new TextSpan(
                                                children: <TextSpan>[
                                                  new TextSpan(
                                                    text: 'Bandsaw ',
                                                    style: GoogleFonts.rubik(
                                                      color: Color(0xff159deb),
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
                                            new RichText(
                                              text: new TextSpan(
                                                children: <TextSpan>[
                                                  new TextSpan(
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
                                            new RichText(
                                              text: new TextSpan(
                                                children: <TextSpan>[
                                                  new TextSpan(
                                                    text: 'ChopSaw ',
                                                    style: GoogleFonts.rubik(
                                                      color: Color(0xff159deb),
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
                                            new RichText(
                                              text: new TextSpan(
                                                children: <TextSpan>[
                                                  new TextSpan(
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
                              new RichText(
                                text: new TextSpan(
                                  children: <TextSpan>[
                                    new TextSpan(
                                        text: 'Incoming ',
                                        style: GoogleFonts.rubik(
                                          color: Colors.white,
                                          fontSize: 25.0,
                                        )),
                                    new TextSpan(
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
                                    padding: EdgeInsets.all(15.0),
                                    child: new LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      animation: true,
                                      lineHeight: 30.0,
                                      animationDuration: 1000,
                                      backgroundColor: Color(0xff26292c),
                                      percent: 0.75,
                                      center: new RichText(
                                        text: new TextSpan(
                                          children: <TextSpan>[
                                            new TextSpan(
                                                text: 'Falcon 500: ',
                                                style: GoogleFonts.rubik(
                                                  color: Colors.white,
                                                  fontSize: 15.0,
                                                )),
                                            new TextSpan(
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
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      progressColor: Color(0xff159deb),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: new LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      animation: true,
                                      lineHeight: 30.0,
                                      animationDuration: 1000,
                                      backgroundColor: Color(0xff26292c),
                                      percent: 0.75,
                                      center: new RichText(
                                        text: new TextSpan(
                                          children: <TextSpan>[
                                            new TextSpan(
                                                text: 'Falcon 500: ',
                                                style: GoogleFonts.rubik(
                                                  color: Colors.white,
                                                  fontSize: 15.0,
                                                )),
                                            new TextSpan(
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
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      progressColor: Color(0xff159deb),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: new LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      animation: true,
                                      lineHeight: 30.0,
                                      animationDuration: 1000,
                                      backgroundColor: Color(0xff26292c),
                                      percent: 0.75,
                                      center: new RichText(
                                        text: new TextSpan(
                                          children: <TextSpan>[
                                            new TextSpan(
                                                text: 'Falcon 500: ',
                                                style: GoogleFonts.rubik(
                                                  color: Colors.white,
                                                  fontSize: 15.0,
                                                )),
                                            new TextSpan(
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
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      progressColor: Color(0xff159deb),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: new LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      animation: true,
                                      lineHeight: 30.0,
                                      animationDuration: 1000,
                                      backgroundColor: Color(0xff26292c),
                                      percent: 0.75,
                                      center: new RichText(
                                        text: new TextSpan(
                                          children: <TextSpan>[
                                            new TextSpan(
                                                text: 'Falcon 500: ',
                                                style: GoogleFonts.rubik(
                                                  color: Colors.white,
                                                  fontSize: 15.0,
                                                )),
                                            new TextSpan(
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
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      progressColor: Color(0xff159deb),
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
            ],
          ),
        ],
      ),
    );
  }
}
