import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class hoursPage extends StatefulWidget {
  const hoursPage({Key key}) : super(key: key);

  @override
  _hoursPageState createState() => _hoursPageState();
}

class _hoursPageState extends State<hoursPage> {
  Location location = new Location();

  @override
  void initState() {
    location.enableBackgroundMode(enable: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              text: "37 hr, 49 min, 0 sec",
              style: GoogleFonts.rubik(
                color: Colors.white,
                fontSize: 21.0,
              ),
            ),
          ),
          ElevatedButton(
            child: Text("Get Location"),
            onPressed: () async {
              var currentLocation = await location.getLocation();

              final latitude = currentLocation.latitude;
              final longitude = currentLocation.longitude;
              final accuracy = currentLocation.accuracy;

              print("Latitude: $latitude");
              print("Longitude: $longitude");
              print("Accuracy: $accuracy meters");
            },
          ),
          ElevatedButton(
            child: Text("Verify Geofence"),
            onPressed: () async {
              var currentLocation = await location.getLocation();

              final longitude = currentLocation.longitude;
              final latitude = currentLocation.latitude;

              print("Latitude: $latitude");
              print("Longitude: $longitude");

              if (latitude > 37.42193608134135 &&
                  latitude < 37.42206873207847 &&
                  longitude > -122.08428558910641 &&
                  longitude < -122.08391431794179) {
                print("In range!");
              } else {
                print("Not in range :(");
              }
            },
          ),
        ],
      ),
    );
  }
}
