import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class toolsPage extends StatelessWidget {
  const toolsPage({Key key, this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    return ToolWidget();
  }
}

class ToolWidget extends StatelessWidget {
  const ToolWidget({Key key}) : super(key: key);

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
                padding: EdgeInsets.all(7.0),
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
                        child: Text('CHECKOUT',
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
                        child: Text('CHECKIN',
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
