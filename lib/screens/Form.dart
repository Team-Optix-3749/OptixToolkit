import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:OptixToolkit/services/firebase.dart';
import 'package:OptixToolkit/services/NavigationService.dart';
import 'Home.dart';

class FormPage extends StatefulWidget {
  FormPage({Key key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final Color background = Color(0xff26292c);
  final Color blue = Color(0xff159deb);
  final Color white = Color(0xffffffff);
  final Color gray = Color(0xff3A3D41);
  final Color subtleGray = Color(0xffcccccc);
  final Color divider = Color(0xff3a3d41);

  StreamSubscription<FirebaseUser> sub;

  @override
  void initState() {
    super.initState();
    sub = Auth.AuthState().listen((event) {
      if (event != null) {
        NavigationService.navigateTo(PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                MyStatefulWidget(user: event)));
      }
    });
  }

  @override
  void dispose() {
    if (sub != null) sub.cancel();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Center(
            child: Text("LOGIN",
                style: GoogleFonts.rubik(fontWeight: FontWeight.bold))),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Container(
                      width: 300,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Email';
                          }
                          return null;
                        },
                        controller: emailController,
                        style: GoogleFonts.rubik(color: Colors.white),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: gray,
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0)),
                          hintStyle: GoogleFonts.rubik(color: subtleGray),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 300,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password';
                          }
                          return null;
                        },
                        controller: passwordController,
                        obscureText: true,
                        style: GoogleFonts.rubik(color: Colors.white),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: gray,
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0)),
                          hintStyle: GoogleFonts.rubik(color: subtleGray),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: 300,
                      child: Divider(
                        color: divider,
                        height: 20,
                        thickness: 2,
                        endIndent: 0,
                      ),
                    ),
                    SizedBox(height: 5),
                    ButtonTheme(
                      minWidth: 300,
                      height: 50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0)),
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Auth.signIn(emailController.text,
                                passwordController.text, context);
                          }
                        },
                        child: Text('LOG IN',
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.bold, color: white)),
                        color: blue,
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(height: 5),
                    
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
