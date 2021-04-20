import 'package:flutter/material.dart';

class ShowInformation  {
  final TextEditingController answerController = new TextEditingController();
  final VoidCallback onTransferAccepted;
  ShowInformation({this.onTransferAccepted});

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
                if (message == "transfer accepted") {
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pop(true);
                  onTransferAccepted();
                } else {
                  Navigator.of(context).pop(true);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void confirmDialog(BuildContext context, String question, String answer) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            question,
          ),
          actions: <Widget>[
            Container(
                width: 300,
                height: 100,
                child :TextField(
                    controller: answerController,
                    decoration: InputDecoration(labelText: "secret answer :"))),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                if (answerController.text == answer) {
                  showMyDialog(context, "transfer accepted");
                } else {
                  showMyDialog(context, "transfer refused, wrong answer");
                }
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}