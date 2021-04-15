import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class obscureTextField extends StatelessWidget {
  const obscureTextField({
    Key key,
    @required this.controller,
    @required this.message,
  }) : super(key: key);

  final TextEditingController controller;
  final String message;

  @override
  Widget build(BuildContext context) {
    return
      TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          labelText: message,
        ),
      );
  }
}