import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class partsPage extends StatelessWidget {
  const partsPage({Key key, this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    return PartsWidget();
  }
}

class PartsWidget extends StatelessWidget {
  const PartsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                color: Color(0xff3a3d41),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 170,
                      height: 55,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text('ADD A PART',
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        color: Color(0xff159deb),
                      ),
                    ),
                    ButtonTheme(
                      minWidth: 170,
                      height: 55,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text('EDIT A PART',
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
              margin: EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Shopping ',
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 330,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
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
                                            fontSize: 20.0),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Christopher\n",
                                          ),
                                          TextSpan(
                                            text: "Band Saw",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
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
                                        style: GoogleFonts.rubik(
                                            color: Colors.white,
                                            fontSize: 22.0),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "12pm - 1pm",
                                            style: TextStyle(
                                                color: Color(0xff159deb),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 330,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
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
                                            fontSize: 20.0),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Christopher\n",
                                          ),
                                          TextSpan(
                                            text: "Band Saw",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
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
                                        style: GoogleFonts.rubik(
                                            color: Colors.white,
                                            fontSize: 22.0),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "12pm - 1pm",
                                            style: TextStyle(
                                                color: Color(0xff159deb),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 330,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
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
                                            fontSize: 20.0),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Christopher\n",
                                          ),
                                          TextSpan(
                                            text: "Band Saw",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
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
                                        style: GoogleFonts.rubik(
                                            color: Colors.white,
                                            fontSize: 22.0),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "12pm - 1pm",
                                            style: TextStyle(
                                                color: Color(0xff159deb),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 330,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
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
                                            fontSize: 20.0),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Christopher\n",
                                          ),
                                          TextSpan(
                                            text: "Band Saw",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
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
                                        style: GoogleFonts.rubik(
                                            color: Colors.white,
                                            fontSize: 22.0),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "12pm - 1pm",
                                            style: TextStyle(
                                                color: Color(0xff159deb),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
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
              ),
            ),
            const SizedBox(height: 600),
          ],
        ),
      ),
    );
  }
}
