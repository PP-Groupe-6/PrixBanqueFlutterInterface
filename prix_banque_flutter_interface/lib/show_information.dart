import 'package:flutter/material.dart';
import 'dart:async';

class ShowInformation {
  final TextEditingController answerController = new TextEditingController();

  void showMyDialog(BuildContext context, String message) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            message,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  bool confirmDialog(BuildContext context, String question, String answer) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            question,
          ),
          actions: <Widget>[
            TextField(
                controller: answerController,
                decoration: InputDecoration(labelText: "secret answer :")),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                if (answerController.text == answer) {
                  //showMyDialog(context, "transfer accepted");
                  return true;
                } else {
                  //showMyDialog(context, "transfer refused, wrong answer");
                  return false;
                }
                Navigator.of(context).pop(true);
              },
            ),
            // TextButton(
            //   child: const Text('Close'),
            //   onPressed: () {
            //     Navigator.of(context).pop(true);
            //   },
            // ),
          ],
        );
      },
    );
  }
}
