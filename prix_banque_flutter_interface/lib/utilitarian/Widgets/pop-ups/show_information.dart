import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/utilitarian/json_http.dart';

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
                  onTransferAccepted();
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