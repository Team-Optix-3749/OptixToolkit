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
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
            width: 400,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text("test"),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12, top: 17, right: 12, bottom: 0),
            width: 400,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
