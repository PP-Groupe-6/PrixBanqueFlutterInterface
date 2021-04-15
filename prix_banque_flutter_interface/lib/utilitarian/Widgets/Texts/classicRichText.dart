import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class classicRichText extends StatelessWidget {
  const classicRichText({
    @required this.myText,
    @required this.snapshot,
    Key key,
  }) : super(key: key);

  final String myText;
  final double myTitleFontSize=16;
  final double mySubtitleFontSize=13;
  final Color myTitleColor=Colors.blue;
  final Color mySubtitleColor=Colors.black;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: myText,
            style: TextStyle(
                color: myTitleColor, fontSize: myTitleFontSize),
            children: [
              TextSpan(
                text: snapshot.data.transferAmount
                    .toString(),
                style: TextStyle(
                    color: mySubtitleColor, fontSize: mySubtitleFontSize),
              )
            ]));
  }
}