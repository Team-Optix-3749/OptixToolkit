// Flutter imports:
import 'package:flutter/material.dart';
import 'package:OptixToolkit/services/Good.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import 'package:OptixToolkit/services/firebase.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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

  @override
  void dispose() {
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
        centerTitle: true,
        title: Text(
          "FORGET PASSWORD",
          style: GoogleFonts.rubik(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xff159deb),
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
                          if (value == null || value.isEmpty) {
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
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                            Auth.sendPasswordResetEmail(
                                emailController.text, context);
                            Good.showGood(context, "Sent!");
                          }
                        },
                        child: Text('Forget Password',
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.bold, color: white)),
                        style: ElevatedButton.styleFrom(backgroundColor: blue)
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(height: 5),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
