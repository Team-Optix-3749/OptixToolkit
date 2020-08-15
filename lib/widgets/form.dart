import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.isLogin}) : super(key: key);

  final String title;
  final bool isLogin;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _username = "default";
  String _password = "default";
  final _formKey = GlobalKey<FormState>();

  void _changeWord() {
    String word = myController.text;
    setState(() {
      _username = word;
    });
    myController.text = "";
  }

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
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
                  // Add TextFormFields and RaisedButton here.
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Username';
                      }
                      return null;
                    },
                  ),
                  if (!widget.isLogin)
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'bruh';
                        }
                        return null;
                      },
                    ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password';
                      }
                      return null;
                    },
                  ),
                  RaisedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, otherwise false.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.

                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
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

// class MyCustomForm extends StatefulWidget {
//   @override
//   MyCustomFormState createState() {
//     return MyCustomFormState();
//   }
// }

// // Define a corresponding State class.
// // This class holds data related to the form.
// class MyCustomFormState extends State<MyCustomForm> {
//   // Create a global key that uniquely identifies the Form widget
//   // and allows validation of the form.
//   //
//   // Note: This is a `GlobalKey<FormState>`,
//   // not a GlobalKey<MyCustomFormState>.
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     // Build a Form widget using the _formKey created above.
//     return
//     );
//   }
// }
