import 'package:OptixToolkit/services/GoodPop.dart';
import 'package:OptixToolkit/ui/Loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:OptixToolkit/services/database.dart';
import 'package:provider/provider.dart';

class hoursPage extends StatelessWidget {
  const hoursPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      FutureProvider<int>.value(
          value: Database.getTime(Provider.of<IdTokenResult>(context), context)),
      FutureProvider<int>.value(
          value: Database.getMeetingCount(Provider.of<IdTokenResult>(context), context))
    ], child: hoursPageLoaded());
    // return FutureBuilder<int>(
    //   future: Database.getTime(Provider.of<IdTokenResult>(context), context),
    //   builder: (context, snapshot) {
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.waiting:
    //         return Loading();
    //       default:
    //         if (snapshot.hasError)
    //           return Text('Error: ${snapshot.error}');
    //         else
    //           return hoursPageLoaded(
    //             time: snapshot.data,
    //           );
    //     }
    //   },
    // );
  }
}

class hoursPageLoaded extends StatefulWidget {
  final int time;
  final int meetingCount;
  const hoursPageLoaded({Key key, this.time, this.meetingCount}) : super(key: key);

  @override
  _hoursPageState createState() => _hoursPageState(this.time, this.meetingCount);
}

class _hoursPageState extends State<hoursPageLoaded> {
  int time;
  int meetingCount;

  _hoursPageState(int time, int meetingCount) {
    this.time = time;
    this.meetingCount = meetingCount;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final checkInCodeController = TextEditingController();
    final checkOutCodeController = TextEditingController();

    var time = Provider.of<int>(context);
    var meetingCount = Provider.of<int>(context);
    if (time == null || meetingCount == null) return Loading();

    final Color formBackground = Color(0xff3A3D41);
    final Color subtleGray = Color(0xffcccccc);
    final Color green = Color(0xff15ee07);
    final Color red = Color(0xffd5212c);
    final Color yellow = Color(0xffebe712);
    final Color orange = Color(0xffff9415);

    final Map<String, TextStyle> statusColor = {
      "logging": GoogleFonts.rubik(
        color: green,
        fontWeight: FontWeight.bold,
        fontSize: 25.0,
      ),
      "offSeason": GoogleFonts.rubik(
        color: orange,
        fontWeight: FontWeight.bold,
        fontSize: 25.0,
      ),
      "notLogging": GoogleFonts.rubik(
        color: yellow,
        fontWeight: FontWeight.bold,
        fontSize: 25.0,
      ),
      "error": GoogleFonts.rubik(
        color: red,
        fontWeight: FontWeight.bold,
        fontSize: 25.0,
      ),
    };

    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      primary: Colors.blue,
      minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 60.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // <-- Radius
      ),
    );

    String msToTime(duration) {
      var hours = ((duration / (1000*60*60))).floor();
      var minutes = ((duration / (1000*60)) % 60).floor();
      var seconds = ((duration / 1000) % 60).floor();

      var hoursStr = "${(hours < 10) ? "0${hours}" : hours}";
      var minutesStr = "${(minutes < 10) ? "0${minutes}" : minutes}";
      var secondsStr = "${(seconds < 10) ? "0${seconds}" : seconds}";

      print(hoursStr);
      print(minutesStr);
      print(secondsStr);

      return hoursStr + " hr, " + minutesStr + " min, " + secondsStr + " sec";
    }

    Future<void> _showMyDialogCheckIn() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Code",
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.bold,
                color: Color(0xff159deb),
              ),
            ),
            backgroundColor: Color(0xff26292c),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextFormField(
                    controller: checkInCodeController,
                    style: GoogleFonts.rubik(color: Colors.white),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: formBackground,
                      hintText: 'Enter code',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0)),
                      hintStyle: GoogleFonts.rubik(color: subtleGray),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Cancel',
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.bold,
                    color: red,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'Approve',
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff159deb),
                  ),
                ),
                onPressed: () async {
                  print("Handling on pressed");
                  var result = await Database.checkIn(
                      Provider.of<IdTokenResult>(context, listen: false),
                      checkInCodeController.text,
                      context);
                  print("Result of the request below: ");
                  print(result);
                  if (result) {
                    GoodPop.showGood(context, "Your hours are being tracked.");
                  }
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> _showMyDialogCheckOut() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Code",
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.bold,
                color: Color(0xff159deb),
              ),
            ),
            backgroundColor: Color(0xff26292c),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextFormField(
                    controller: checkOutCodeController,
                    style: GoogleFonts.rubik(color: Colors.white),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: formBackground,
                      hintText: 'Enter code',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0)),
                      hintStyle: GoogleFonts.rubik(color: subtleGray),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Cancel',
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.bold,
                    color: red,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'Approve',
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff159deb),
                  ),
                ),
                onPressed: () async {
                  print("Handling on pressed");
                  var result = await Database.checkOut(
                      Provider.of<IdTokenResult>(context, listen: false),
                      checkOutCodeController.text,
                      context);
                  print("Result of the request below: ");
                  print(result);
                  if (result) {
                    GoodPop.showGood(context, "Your hours have been logged.");
                  }
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
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: msToTime(time),
                      style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 31.0,
                      ),
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
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xff3a3d41),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Status: ',
                                style: GoogleFonts.rubik(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                )),
                            TextSpan(
                              text: 'Logging',
                              style: GoogleFonts.rubik(
                                fontWeight: FontWeight.bold,
                                color: green,
                                fontSize: 25.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    child: Text("CHECK IN"),
                    style: buttonStyle,
                    onPressed: () {
                      print("Checking in...");
                      _showMyDialogCheckIn();
                    },
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    child: Text("CHECK OUT"),
                    style: buttonStyle,
                    onPressed: () {
                      print("Checking out...");
                      _showMyDialogCheckOut();
                    },
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xff3a3d41),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Stats',
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Total Meetings: ',
                            style: GoogleFonts.rubik(
                              color: Colors.white,
                              fontSize: 25.0,
                            )),
                        TextSpan(
                          text: meetingCount.toString(),
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontSize: 25.0,
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
