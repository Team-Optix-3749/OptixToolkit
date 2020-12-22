// Flutter imports:
import 'package:OptixToolkit/screens/Loading.dart';
import 'package:OptixToolkit/screens/subwidgets/PartCard.dart';
import 'package:OptixToolkit/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import 'package:OptixToolkit/screens/pages/subpages/AddPart.dart';
import 'package:OptixToolkit/services/NavigationService.dart';
import 'package:provider/provider.dart';

class partsPage extends StatelessWidget {
  const partsPage({Key key, this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Part>>(
      future: Database.getParts(Provider.of<IdTokenResult>(context)),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Loading();
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              return PartsWidget(parts: snapshot.data, idToken: Provider.of<IdTokenResult>(context));
        }
      },
    );
  }
}

class PartsWidget extends StatefulWidget {
  final List<Part> parts;
  final IdTokenResult idToken;

  PartsWidget({Key key, this.parts, this.idToken}) : super(key: key);

  @override
  _partState createState() => _partState(this.parts, this.idToken);
}

class _partState extends State<PartsWidget> {
  List<Part> parts;
  IdTokenResult idToken;

  _partState(List<Part> parts, IdTokenResult idToken) {
    this.parts = parts;
    this.idToken = idToken;
  }

  @override
  Widget build(BuildContext context) {
    final Color green = Color(0xff3ce887);
    final Color yellow = Color(0xffe6d040);
    final Color orange = Colors.orange;
    final Color red = Colors.red;
    final Color pink = Colors.pink;

    final Map<String, TextStyle> styleMap = {
      "Arrived": GoogleFonts.rubik(
        color: green,
      ),
      "Shipped": GoogleFonts.rubik(
        color: yellow,
      ),
      "Ordered": GoogleFonts.rubik(
        color: orange,
      ),
      "Failure": GoogleFonts.rubik(
        color: pink,
      ),
    };

    Widget doneButton = FlatButton(
      child: Text(
        "Done",
        style: GoogleFonts.rubik(
          fontWeight: FontWeight.bold,
          color: Color(0xff159deb),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xff3a3d41),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.88,
                    height: 55,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    child: RaisedButton(
                      onPressed: () {
                        NavigationService.goTo(
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                AddPart(),
                          ),
                        );
                      },
                      child: Text(
                        'ADD A PART',
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white),
                      ),
                      color: Color(0xff159deb),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
            width: 400,
            height: MediaQuery.of(context).size.height * 0.63,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xff3a3d41),
            ),
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Shopping ',
                                style: GoogleFonts.rubik(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                )),
                            TextSpan(
                              text: 'List',
                              style: GoogleFonts.rubik(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 25.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                      child: RefreshIndicator(
                    onRefresh: () async {
                      var partsRes = await Database.getParts(idToken);
                      setState(() {
                        this.parts = partsRes;
                      });
                      print("Refreshsed");
                    },
                    child: ListView(
                        children: parts
                            .map<Widget>((part) => PartCard(part: part))
                            .toList()
                            .reversed
                            .toList()),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
