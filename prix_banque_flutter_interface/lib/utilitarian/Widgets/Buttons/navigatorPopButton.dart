import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorPopButton extends StatelessWidget {
  const NavigatorPopButton({
    Key key,
    @required this.myMessage,
  }) : super(key: key);

  final String myMessage;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(myMessage));
  }
}
