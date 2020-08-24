import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class partsPage extends StatelessWidget {
  const partsPage({Key key, this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    return PartsWidget();
  }
}

class PartsWidget extends StatelessWidget {
  const PartsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 12, top: 10, right: 12, bottom: 0),
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                color: Color(0xff3a3d41),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 110,
                      height: 55,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text('RESERVE',
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        color: Color(0xff159deb),
                      ),
                    ),
                    ButtonTheme(
                      minWidth: 110,
                      height: 55,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text('CHECK OUT',
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        color: Color(0xff159deb),
                      ),
                    ),
                    ButtonTheme(
                      minWidth: 110,
                      height: 55,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text('CHECK IN',
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        color: Color(0xff159deb),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 600),
          ],
        ),
      ),
    );
  }
}
