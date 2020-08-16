import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

class FormPage extends StatefulWidget {
  FormPage({Key key, this.title, this.isLogin}) : super(key: key);

  final String title;
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

  bool isInProcess = false;

  Future signIn(BuildContext context) async {
    if (isInProcess) return;
    isInProcess = true;
    if (widget.isLogin) {
      //do login
      try {
        AuthResult result = await widget._auth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        _continue(context);
      } catch (e) {
        print(e);
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
      isInProcess = false;
    } else {
      try {
        AuthResult result = await widget._auth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        print(result.user.email);
      } catch (e) {
        print(e);
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

  void _continue(BuildContext context) {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                MyStatefulWidget()));
  }

  @override
  void initState() {
    widget._auth.onAuthStateChanged;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                        signIn(context);
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
