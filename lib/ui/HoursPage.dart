import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:location/location.dart';

class hoursPage extends StatefulWidget {
  const hoursPage({Key key}) : super(key: key);

  @override
  _hoursPageState createState() => _hoursPageState();
}

class _hoursPageState extends State<hoursPage> {
  Location location = new Location();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color green = Color(0xff15ee07);

    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      primary: Colors.blue,
      minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 60.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // <-- Radius
      ),
    );

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
                      text: "37 hr, 49 min, 0 sec",
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
                  const SizedBox(height: 15),
                  ElevatedButton(
                    child: Text("CHECK IN"),
                    style: buttonStyle,
                    onPressed: () {
                      print("Checking in...");
                    },
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    child: Text("CHECK OUT"),
                    style: buttonStyle,
                    onPressed: () {
                      print("Checking out...");
                    },
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Status',
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
                          text: '14',
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
          // RichText(
          //   text: TextSpan(
          //     text: "37 hr, 49 min, 0 sec",
          //     style: GoogleFonts.rubik(
          //       color: Colors.white,
          //       fontSize: 21.0,
          //     ),
          //   ),
          // ),
          // ElevatedButton(
          //   child: Text("Get Location"),
          //   onPressed: () async {
          //     var currentLocation = await location.getLocation();

          //     final latitude = currentLocation.latitude;
          //     final longitude = currentLocation.longitude;
          //     final accuracy = currentLocation.accuracy;

          //     print("Latitude: $latitude");
          //     print("Longitude: $longitude");
          //     print("Accuracy: $accuracy meters");
          //   },
          // ),
          // ElevatedButton(
          //   child: Text("Verify Geofence"),
          //   onPressed: () async {
          //     var currentLocation = await location.getLocation();

          //     final longitude = currentLocation.longitude;
          //     final latitude = currentLocation.latitude;

          //     print("Latitude: $latitude");
          //     print("Longitude: $longitude");

          //     if (latitude > 37.42193608134135 &&
          //         latitude < 37.42206873207847 &&
          //         longitude > -122.08428558910641 &&
          //         longitude < -122.08391431794179) {
          //       print("In range!");
          //     } else {
          //       print("Not in range :(");
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
