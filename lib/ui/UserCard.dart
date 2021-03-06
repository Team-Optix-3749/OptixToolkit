// Flutter imports:
import 'package:OptixToolkit/services/NavigationService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import 'package:OptixToolkit/services/database.dart';
import 'package:provider/provider.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: 330,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xff26292c),
      ),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                RichText(
                  text: TextSpan(
                    style:
                        GoogleFonts.rubik(color: Colors.white, fontSize: 10.0),
                    children: <TextSpan>[
                      TextSpan(
                        text: "${user.displayName}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ButtonTheme(
                  minWidth: 100,
                  height: 40,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: RaisedButton(
                    onPressed: () async {
                      var res = await Database.removeUser(
                          Provider.of<IdTokenResult>(context, listen: false),
                          user.uid,
                          context);
                      if (res) {
                        print("removed");
                      }
                    },
                    child: Text(
                      "Remove",
                      style: GoogleFonts.rubik(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    color: Color(0xffd5212c),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
