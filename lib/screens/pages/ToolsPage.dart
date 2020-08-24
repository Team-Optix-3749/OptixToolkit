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
            Container(
              margin: EdgeInsets.only(left: 12, top: 10, right: 12, bottom: 0),
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                color: Color(0xff3a3d41),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
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
                                  text: 'Tool ',
                                  style: GoogleFonts.rubik(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                  )),
                              TextSpan(
                                text: 'Reservations',
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
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          width: 340,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: Color(0xff26292c),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: GoogleFonts.rubik(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Christopher\n",
                                          ),
                                          TextSpan(
                                            text: "BandSaw",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Column(
            //   children: [
            //     Container(
            //       margin:
            //           EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
            //       width: 400,
            //       height: MediaQuery.of(context).size.height,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(7.0),
            //         color: Color(0xff3a3d41),
            //       ),
            //       child: Padding(
            //         padding: EdgeInsets.all(15.0),
            //         child: Column(
            //           children: [
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 RichText(
            //                   text: TextSpan(
            //                     children: <TextSpan>[
            //                       TextSpan(
            //                           text: 'Tool ',
            //                           style: GoogleFonts.rubik(
            //                             color: Colors.white,
            //                             fontSize: 25.0,
            //                           )),
            //                       TextSpan(
            //                         text: 'Reservations',
            //                         style: GoogleFonts.rubik(
            //                           fontWeight: FontWeight.bold,
            //                           color: Colors.white,
            //                           fontSize: 25.0,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             Column(
            //               children: [
            //                 Container(
            //                   margin: EdgeInsets.only(
            //                       left: 12, top: 17, right: 12, bottom: 0),
            //                   width: 400,
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(17.0),
            //                     color: Color(0xFF26292C),
            //                   ),
            //                   child: Padding(
            //                     padding: EdgeInsets.all(15.0),
            //                     child: Column(
            //                       children: [
            //                         Row(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.start,
            //                           children: [
            //                             RichText(
            //                               text: TextSpan(
            //                                 style: GoogleFonts.rubik(
            //                                     color: Colors.white,
            //                                     fontSize: 20.0),
            //                                 children: <TextSpan>[
            //                                   TextSpan(
            //                                     text: "Christopher\n",
            //                                   ),
            //                                   TextSpan(
            //                                     text: "BandSaw",
            //                                     style: TextStyle(
            //                                         fontWeight:
            //                                             FontWeight.bold),
            //                                   ),
            //                                 ],
            //                               ),
            //                             )
            //                           ],
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             )
            //           ],
            //         ),
            //       ),
            //     )
            //   ],
            // ),
            const SizedBox(height: 600),
          ],
        ),
      ),
    );
  }
}
