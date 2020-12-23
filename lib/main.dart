// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:OptixToolkit/ui/Form.dart';
import 'package:OptixToolkit/ui/Home.dart';
import 'package:OptixToolkit/ui/Loading.dart';
import 'package:OptixToolkit/services/firebase.dart';
import 'services/NavigationService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return MultiProvider(
      providers: [StreamProvider<FirebaseUser>.value(value: Auth.authState())],
      child: MaterialApp(
        title: 'OptixToolkit',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        navigatorKey: NavigationService.navigatorKey,
        home: Consumer<FirebaseUser>(
          builder: (context, user, child) {
            if (user != null) {
              return FutureProvider<IdTokenResult>(
                create: (_) => user.getIdToken(),
                child: MainApp(),
              );
            } else {
              return MainApp();
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
