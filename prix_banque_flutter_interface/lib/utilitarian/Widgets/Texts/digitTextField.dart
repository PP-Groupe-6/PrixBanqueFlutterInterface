import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class digitTextField extends StatelessWidget {
  const digitTextField({
    Key key,
    @required this.controller,
    @required this.message,
  }) : super(key: key);
  final String message;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: message,
      ),
    );
  }
}