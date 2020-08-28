import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:OptixToolkit/services/firebase.dart';
import 'services/NavigationService.dart';
import 'package:flutter/material.dart';
import 'package:OptixToolkit/screens/Form.dart';
import 'package:OptixToolkit/screens/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [StreamProvider<FirebaseUser>.value(value: Auth.AuthState())],
      child: MaterialApp(
        title: 'Optix Toolkit',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        navigatorKey: NavigationService.navigatorKey,
        home: MainApp(),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider.of<FirebaseUser>(context) == null
        ? FormPage()
        : MyStatefulWidget();
  }
}
