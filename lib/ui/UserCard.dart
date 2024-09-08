// Flutter imports:
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import 'package:OptixToolkit/ui/UserModal.dart';
import 'package:OptixToolkit/services/database.dart';
import 'package:provider/provider.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({Key? key, required this.user}) : super(key: key);

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return UserModal(user: user);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        _showMyDialog(context);
      },
      child: Container(
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
                      style: GoogleFonts.rubik(
                          color: Colors.white, fontSize: 10.0),
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
                    child: ElevatedButton(
                      onPressed: () async {
                        var res = await Database.removeUser(
                            Provider.of<firebase.IdTokenResult>(context, listen: false),
                            user.uid,
                            context);
                        if (res) {
                          print("removed");
                          Navigator.of(context).pop();
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
                      style: ElevatedButton.styleFrom(backgroundColor: Color(0xffd5212c))
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
