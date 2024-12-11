// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:OptixToolkit/ui/BarcodeScanner.dart';
import 'package:OptixToolkit/ui/HoursPage.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import 'package:OptixToolkit/Icons.dart';
import 'package:OptixToolkit/ui/HomePage.dart';
import 'package:OptixToolkit/ui/ProfilePage.dart';
// import 'package:OptixToolkit/ui/tools/ToolsPage.dart';
import 'package:OptixToolkit/services/firebase.dart';
import 'package:OptixToolkit/ui/parts/PartReimburse.dart';

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final Color background = Color(0xff26292c);
  final Color lightBackground = Color(0xff3a3d41);
  final Color blue = Color(0xff159deb);
  final Color white = Color(0xffffffff);
  final List<String> titles = [
    "HOME",
    "HOURS",
    "TOOLS",
    "REIMBURSEMENTS",
    "PROFILE"
  ];
  int _selectedIndex = 0;

  void changePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    //LogOut();
  }

  Future LogOut() async {
    await Auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      homePage(changePage: changePage),
      hoursPage(),
      ToolReservationPage(),
      PartReimburse(),
      profilePage(key: null,),
      Container(
        child: Column(
          children: [
            Text("Loading Profile"),
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(titles[_selectedIndex],
                style: GoogleFonts.rubik(fontWeight: FontWeight.bold))),
        backgroundColor: blue,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      backgroundColor: background,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: background,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(Icons.home),
            ),
          label: ""
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(Icons.access_time_filled_rounded),
            ),
          label: ""
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(FlutterIcons.tools),
            ),
          label: ""
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              // child: Icon(FlutterIcons.parts),
              child: Icon(Icons.monetization_on_rounded),
            ),
          label: ""
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(Icons.person),
            ),
          label: ""
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: white,
        selectedItemColor: blue,
        onTap: changePage,
      ),
    );
  }
}
