// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:OptixToolkit/ui/Form.dart';
import 'package:OptixToolkit/ui/Home.dart';
import 'package:OptixToolkit/ui/Loading.dart';
import 'package:OptixToolkit/services/firebase.dart';
import 'services/NavigationService.dart';

import 'package:OptixToolkit/ui/BarcodeScanner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      providers: [
        StreamProvider<firebase.User?>.value(
          value: Auth.authState(),
          initialData: null,
        )
      ],
      child: Consumer<firebase.User?>(
        builder: (context, user, child) {
          if (user != null) {
            return FutureProvider<firebase.IdTokenResult?>(
              initialData: null,
              create: (_) => user.getIdTokenResult(),
              child: MaterialApp(
                title: 'OptixToolkit',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                navigatorKey: NavigationService.navigatorKey,
                home: MainApp(),
                debugShowCheckedModeBanner: false,
              ),
            );
          } else {
            return MaterialApp(
              title: 'OptixToolkit',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              navigatorKey: NavigationService.navigatorKey,
              home: MainApp(),
            );
          }
        },
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<firebase.User?>(context) == null) return ToolReservationPage();
    if (Provider.of<firebase.IdTokenResult?>(context) == null) return Loading();
    return MyStatefulWidget();
  }
}
