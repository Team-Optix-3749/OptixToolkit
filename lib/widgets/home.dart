import 'package:flutter/material.dart';
import '../my_flutter_app_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "./form.dart";

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key, this.title}) : super(key: key);

  final String title;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final Color background = Color(0xff26292c);
  final Color lightBackground = Color(0xff3a3d41);
  final Color blue = Color(0xff159deb);
  final Color white = Color(0xffffffff);
  final List<String> titles = ["Home", "OptixTools", "OptixParts", "Profile"];
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    Column(
      children: [
        Container(
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: Color(0xff3a3d41),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Hey there, Tux!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
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
        Text("OptixTools"),
      ],
    ),
    Column(
      children: [
        Text("OptixParts"),
      ],
    ),
    Column(
      children: [
        Text("Loading Profile"),
      ],
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    CheckAuthState();
    // LogOut();
  }

  Future LogOut() async {
    await widget._auth.signOut();
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                FormPage(isLogin: true)));
  }

  void _goToLogin() {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                FormPage(isLogin: true)));
  }

  Future CheckAuthState() async {
    await for (var event in widget._auth.onAuthStateChanged) {
      if (event == null) {
        _goToLogin();
      } else {
        GetUserData(event.uid);
      }
    }
  }

  Future GetUserData(String uid) async {
    var doc = await widget._firestore.collection("users").document(uid).get();
    print(doc);
    setState(() {
      _widgetOptions[3] = Text(doc.data['name'], style: optionStyle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(titles[_selectedIndex])),
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
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(FlutterIcons.tools),
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(FlutterIcons.parts),
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(Icons.person),
            ),
            title: Container(),
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: white,
        selectedItemColor: blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
