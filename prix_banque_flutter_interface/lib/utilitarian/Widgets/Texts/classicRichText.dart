import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class classicRichText extends StatelessWidget {
  const classicRichText({
    @required this.myText,
    @required this.snapshot,
    Key key,
  }) : super(key: key);

  final String myText;
  final double myTitleFontSize=35;
  final double mySubtitleFontSize=30;
  final Color myTitleColor=Colors.blue;
  final Color mySubtitleColor=Colors.black;
  final dynamic snapshot;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: myText,
            style: TextStyle(
                 color : Theme.of(context).primaryColor, fontSize: myTitleFontSize), //color: myTitleColor,
            children: [
              TextSpan(
                text: snapshot
                    .toString(),
                style: TextStyle(
                    color : Theme.of(context).accentColor, fontSize: mySubtitleFontSize),
              )
            ]));
  }
}