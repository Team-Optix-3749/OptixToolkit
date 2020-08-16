import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

class FormPage extends StatefulWidget {
  FormPage({Key key, this.isLogin}) : super(key: key);

  final bool isLogin;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      } catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
      isInProcess = false;
    } else {
      try {
        await widget._auth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
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

  @override
  void initState() {
    CheckAuthState();
  }

  Future CheckAuthState() async {
    await for (var event in widget._auth.onAuthStateChanged) {
      if (event != null) {
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
                  )
                ])),
          ],
        ),
      ),
    );
  }
}
