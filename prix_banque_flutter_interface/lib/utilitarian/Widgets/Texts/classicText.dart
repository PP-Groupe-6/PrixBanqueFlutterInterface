import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class classicText extends StatelessWidget {
  const classicText({
    Key key,
    @required this.myColor,
    @required this.myFontSize,
    @required this.myText,
  }) : super(key: key);

  final Color myColor;
  final double myFontSize;
  final String myText;
  @override
  Widget build(BuildContext context) {
    return Text(
      myText,
      style: TextStyle(
        color: myColor,
        fontSize: myFontSize,
      ),
    );
  }
}