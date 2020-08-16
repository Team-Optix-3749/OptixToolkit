import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home.dart';
//import 'auth.dart';

class FormPage extends StatefulWidget {
  FormPage({Key key, this.isLogin}) : super(key: key);

  final bool isLogin;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _firestore = Firestore.instance;

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
            .setData({'uid': res.user.uid, 'name': nameController.text});
        _goToHome();
      } catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
        
      }
      isInProcess = false;
    }
  }

  Future signInWithGoogle() async {
    GoogleSignInAccount googleUser = await widget._googleSignIn.signIn();

    // Step 2
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    AuthResult result = await widget._auth.signInWithCredential(credential);
    FirebaseUser user = result.user;

    // Step 3
    //updateUserData(user);
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
        title: Center(child: Text(widget.isLogin ? "Login" : "Signup")),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  if (!widget.isLogin)
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Name';
                        }
                        return null;
                      },
                      controller: nameController,
                    ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Username';
                      }
                      return null;
                    },
                    controller: emailController,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password';
                      }
                      return null;
                    },
                    controller: passwordController,
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        signIn();
                      }
                    },
                    child: Text(widget.isLogin ? 'Login' : 'Sign Up'),
                    color: blue,
                  ),
                  RaisedButton(
                    onPressed: () => signInWithGoogle(),
                    child: Text("Login With Google"),
                    color: blue,
                  )
                ])),
          ],
        ),
      ),
    );
  }
}
