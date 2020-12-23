// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:loading_animations/loading_animations.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoadingBouncingLine.circle(
      borderColor: Color(0xff159deb),
      borderSize: 3.0,
      size: 50.0,
      backgroundColor: Color(0xff159deb),
      duration: Duration(milliseconds: 1000),
    );
  }
}
