import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';
//import 'auth.dart';

class FormPage extends StatefulWidget {
  FormPage({Key key, this.isLogin}) : super(key: key);

  final bool isLogin;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Firestore _firestore = Firestore.instance;

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

  bool isInProcess = false;

  Future signIn() async {
    if (isInProcess) return;
    isInProcess = true;
    if (widget.isLogin) {
      //do login
      try {
        await widget._auth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        _goToHome();
      } catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
      isInProcess = false;
    } else {
      try {
        AuthResult res = await widget._auth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        await widget._firestore
            .collection("users")
            .document(res.user.uid)
            .setData({'uid': res.user.uid, 'name': nameController.text},
                merge: true);
        _goToHome();
      } catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
      isInProcess = false;
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _goToHome() {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                MyStatefulWidget()));
  }

  void switchPage() {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                FormPage(isLogin: !widget.isLogin)));
  }

  @override
  void initState() {
    CheckAuthState();
  }

  Future CheckAuthState() async {
    await for (var event in widget._auth.onAuthStateChanged) {
      if (event != null && !isInProcess) {
        _goToHome();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Center(
            child: Text(widget.isLogin ? "LOGIN" : "SIGNUP",
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
                    if (!widget.isLogin)
                      Container(
                          width: 300,
                          child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Name';
                                }
                                return null;
                              },
                              controller: nameController,
                              style: GoogleFonts.rubik(color: white),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: gray,
                                hintText: 'Full Name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(9.0)),
                                hintStyle: GoogleFonts.rubik(color: subtleGray),
                              ))),
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
                          style: GoogleFonts.rubik(color: white),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: gray,
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9.0)),
                            hintStyle: GoogleFonts.rubik(color: subtleGray),
                          ),
                        )),
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
                                hintStyle:
                                    GoogleFonts.rubik(color: subtleGray)))),
                    SizedBox(height: 10),
                    ButtonTheme(
                      minWidth: 300,
                      height: 50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0)),
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            signIn();
                          }
                        },
                        child: Text(widget.isLogin ? 'LOG IN' : 'SIGN UP',
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.bold, color: white)),
                        color: blue,
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
                          borderRadius: BorderRadius.circular(7.0),
                          side: BorderSide(color: blue)),
                      child: RaisedButton(
                        onPressed: () => switchPage(),
                        child: Text(widget.isLogin ? "SIGN UP" : "LOG IN",
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.bold, color: white)),
                        color: background,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
