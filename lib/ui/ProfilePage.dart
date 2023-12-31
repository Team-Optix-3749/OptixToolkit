// Flutter imports:
import 'package:OptixToolkit/services/NavigationService.dart';
import 'package:flutter/material.dart';
import 'package:OptixToolkit/ui/UserList.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:OptixToolkit/services/firebase.dart';

class profilePage extends StatelessWidget {
  const profilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final Color background = Color(0xff26292c);
    final Color subtleGray = Color(0xffcccccc);
    final emailController = TextEditingController();
    final Color red = Color(0xffd5212c);

    return Container(
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xff3a3d41),
            ),
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Welcome, ',
                                style: GoogleFonts.rubik(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                )),
                            TextSpan(
                              text: Provider.of<firebase.User>(context)
                                  .displayName
                                  ?.split(" ")[0],
                              style: GoogleFonts.rubik(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 25.0,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Auth.signOut();
                        },
                        child: Icon(
                          Icons.logout,
                          color: red,
                          size: 30.0,
                          semanticLabel: 'LogOut',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
            width: 400,
            height: MediaQuery.of(context).size.height * 0.32,
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
                                text: 'Account ',
                                style: GoogleFonts.rubik(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                )),
                            TextSpan(
                              text: 'Settings',
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
                  const SizedBox(height: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.89,
                          margin: EdgeInsets.only(top: 5),
                          key: _formKey,
                          child: Form(
                            child: Column(
                              children: [
                                Container(
                                  width: 300,
                                  margin: EdgeInsets.only(top: 20),
                                  child: TextFormField(
                                    controller: emailController,
                                    style:
                                        GoogleFonts.rubik(color: Colors.white),
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: background,
                                      hintText: 'Enter Email',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(9.0)),
                                      hintStyle:
                                          GoogleFonts.rubik(color: subtleGray),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: 300,
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        ButtonTheme(
                                          minWidth: 200,
                                          height: 55,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0)),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Auth.sendPasswordResetEmail(
                                                  emailController.text,
                                                  context);
                                            },
                                            child: Text(
                                              'CHANGE PASSWORD',
                                              style: GoogleFonts.rubik(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(backgroundColor: Color(0xff159deb))
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (Provider.of<firebase.IdTokenResult>(context).claims?['admin'] == true)
            Container(
              margin: EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
              width: 400,
              height: MediaQuery.of(context).size.height * 0.20,
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
                                  text: 'Team ',
                                  style: GoogleFonts.rubik(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                  )),
                              TextSpan(
                                text: 'Management',
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.89,
                            margin: EdgeInsets.only(top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ButtonTheme(
                                      minWidth: 200,
                                      height: 55,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0)),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          NavigationService.goTo(
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation1,
                                                      animation2) =>
                                                  UserList(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'MANAGE USERS',
                                          style: GoogleFonts.rubik(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(backgroundColor: Color(0xff159deb))
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          // Container(
          //   margin: EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
          //   width: 400,
          //   height: MediaQuery.of(context).size.height * 0.15,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10.0),
          //     color: Color(0xff3a3d41),
          //   ),
          //   child: Padding(
          //     padding: EdgeInsets.all(15.0),
          //     child: Column(
          //       children: [
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: <Widget>[
          //             RichText(
          //               text: TextSpan(
          //                 children: <TextSpan>[
          //                   TextSpan(
          //                       text: 'User ',
          //                       style: GoogleFonts.rubik(
          //                         color: Colors.white,
          //                         fontSize: 25.0,
          //                       )),
          //                   TextSpan(
          //                     text: 'Stats',
          //                     style: GoogleFonts.rubik(
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.white,
          //                       fontSize: 25.0,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //         const SizedBox(height: 5),
          //         Expanded(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               Container(
          //                 width: MediaQuery.of(context).size.width * 0.89,
          //                 margin: EdgeInsets.only(top: 5),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   children: [
          //                     Row(
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       children: [
          //                         RichText(
          //                           text: TextSpan(
          //                             children: <TextSpan>[
          //                               TextSpan(
          //                                 text: 'Coming Soon!',
          //                                 style: GoogleFonts.rubik(
          //                                   color: Colors.white,
          //                                   fontSize: 25.0,
          //                                 ),
          //                               ),
          //                               // TextSpan(
          //                               //   text: 'Tools Reserved: ',
          //                               //   style: GoogleFonts.rubik(
          //                               //     color: Colors.white,
          //                               //     fontSize: 25.0,
          //                               //   ),
          //                               // ),
          //                               // TextSpan(
          //                               //   text: '100',
          //                               //   style: GoogleFonts.rubik(
          //                               //     color: Color(0xff159deb),
          //                               //     fontSize: 25.0,
          //                               //     fontWeight: FontWeight.bold,
          //                               //   ),
          //                               // ),
          //                             ],
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                     // const SizedBox(height: 5),
          //                     // Row(
          //                     //   mainAxisAlignment: MainAxisAlignment.center,
          //                     //   children: [
          //                     //     RichText(
          //                     //       text: TextSpan(
          //                     //         children: <TextSpan>[
          //                     //           TextSpan(
          //                     //             text: 'Parts Ordered: ',
          //                     //             style: GoogleFonts.rubik(
          //                     //               color: Colors.white,
          //                     //               fontSize: 25.0,
          //                     //             ),
          //                     //           ),
          //                     //           TextSpan(
          //                     //             text: '100',
          //                     //             style: GoogleFonts.rubik(
          //                     //               color: Color(0xff159deb),
          //                     //               fontSize: 25.0,
          //                     //               fontWeight: FontWeight.bold,
          //                     //             ),
          //                     //           ),
          //                     //         ],
          //                     //       ),
          //                     //     ),
          //                     //   ],
          //                     // ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
