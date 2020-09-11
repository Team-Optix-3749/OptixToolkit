import 'package:flutter/material.dart';
import 'package:OptixToolkit/services/NavigationService.dart';
import 'package:OptixToolkit/screens/pages/subpages/AddPart.dart';
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
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('AlertDialog Title'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('This is a demo alert dialog.'),
                  Text('Would you like to approve of this message?'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xff3a3d41),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.89,
                    height: 55,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    child: RaisedButton(
                      onPressed: () {
                        _showMyDialog();
                        // NavigationService.goTo(
                        //   PageRouteBuilder(
                        //     pageBuilder: (context, animation1, animation2) =>
                        //         AddPart(),
                        //   ),
                        // );
                      },
                      child: Text(
                        'ADD A PART',
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white),
                      ),
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
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView(
                      children: [
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
                                            fontSize: 20.0),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Christopher\n",
                                          ),
                                          TextSpan(
                                            text: "Limelight",
                                            style: TextStyle(
                                              color: Color(0xff159deb),
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
                                            text: "Arrived",
                                            style: TextStyle(
                                                color: Color(0xff3ce887),
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
                                            fontSize: 20.0),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Christopher\n",
                                          ),
                                          TextSpan(
                                            text: "Spark Max",
                                            style: TextStyle(
                                              color: Color(0xff159deb),
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
                                            text: "Shipped",
                                            style: TextStyle(
                                                color: Color(0xffe6d040),
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
                                            fontSize: 20.0),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Christopher\n",
                                          ),
                                          TextSpan(
                                            text: "Failane Wheel",
                                            style: TextStyle(
                                              color: Color(0xff159deb),
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
                                            text: "Ordered",
                                            style: TextStyle(
                                                color: Colors.orange,
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
                                            fontSize: 20.0),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Christopher\n",
                                          ),
                                          TextSpan(
                                            text: "Falcon 500",
                                            style: TextStyle(
                                              color: Color(0xff159deb),
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
                                            text: "Not Ordered",
                                            style: TextStyle(
                                                color: Colors.red,
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
                                            fontSize: 20.0),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Christopher\n",
                                          ),
                                          TextSpan(
                                            text: "Limelight",
                                            style: TextStyle(
                                              color: Color(0xff159deb),
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
                                            text: "Arrived",
                                            style: TextStyle(
                                                color: Color(0xff3ce887),
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
                                            fontSize: 20.0),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Christopher\n",
                                          ),
                                          TextSpan(
                                            text: "Spark Max",
                                            style: TextStyle(
                                              color: Color(0xff159deb),
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
                                            text: "Shipped",
                                            style: TextStyle(
                                                color: Color(0xffe6d040),
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
                                            fontSize: 20.0),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Christopher\n",
                                          ),
                                          TextSpan(
                                            text: "Failane Wheel",
                                            style: TextStyle(
                                              color: Color(0xff159deb),
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
                                            text: "Ordered",
                                            style: TextStyle(
                                                color: Colors.orange,
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
                                            fontSize: 20.0),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Christopher\n",
                                          ),
                                          TextSpan(
                                            text: "Falcon 500",
                                            style: TextStyle(
                                              color: Color(0xff159deb),
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
                                            text: "Not Ordered",
                                            style: TextStyle(
                                                color: Colors.red,
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
