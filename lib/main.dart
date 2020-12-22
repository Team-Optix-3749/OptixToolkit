// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:OptixToolkit/screens/Form.dart';
import 'package:OptixToolkit/screens/Home.dart';
import 'package:OptixToolkit/screens/Loading.dart';
import 'package:OptixToolkit/services/firebase.dart';
import 'services/NavigationService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [StreamProvider<FirebaseUser>.value(value: Auth.authState())],
      child: MaterialApp(
        title: 'Optix Toolkit',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        navigatorKey: NavigationService.navigatorKey,
        home: Consumer<FirebaseUser>(
          builder: (context, user, child) {
            if (user) {
              return FutureProvider<IdTokenResult>(
                create: (_) => user.getIdToken(),
                child: MainApp(),
              );
              else {
                return MainApp();
              }
            }
          },
        ),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<FirebaseUser>(context) == null) return FormPage();
    if (Provider.of<IdTokenResult>(context) == null) return Loading();
    return MyStatefulWidget();
  }
}
