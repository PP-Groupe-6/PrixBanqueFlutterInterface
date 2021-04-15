import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class navigatorPushButton extends StatelessWidget {
  const navigatorPushButton({
    Key key,
    this.message,
    this.route,
  }) : super(key: key);

  final String route;
  final String message;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Text(message)
    );
  }
}