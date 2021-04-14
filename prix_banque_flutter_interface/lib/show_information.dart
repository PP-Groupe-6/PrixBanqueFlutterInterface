import 'package:flutter/material.dart';
import 'dart:async';

import 'package:prix_banque_flutter_interface/transfers_management/display_list_transfers.dart';
import 'package:prix_banque_flutter_interface/transfers_management/transfer_model.dart';

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

  void confirmDialog(BuildContext context, String question, String answer, Transfer transfer) {
    final DisplayListTransferState state = DisplayListTransfer.of(context);
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
                  state.removeTransfer(transfer);
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
