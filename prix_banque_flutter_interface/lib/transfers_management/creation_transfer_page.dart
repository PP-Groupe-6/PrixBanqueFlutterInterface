import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prix_banque_flutter_interface/transfers_management/transfer_model.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Builders/futureBuilderTransfer.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicTextField.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/datePickerTextField.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/digitTextField.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/pop-ups/show_information.dart';
import 'package:prix_banque_flutter_interface/utilitarian/json_http.dart';

class CreateTransferPage extends StatefulWidget {
  static const name = "/createTransferPage";

  @override
  _CreateTransferPageState createState() => _CreateTransferPageState();
}

class _CreateTransferPageState extends State<CreateTransferPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController emailReceiverController = TextEditingController();
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  var json = Map<String, String>();
  Future<Transfer> _futureTransfer;
  Future<Transfer> _futureTransfergetted;

  int selectedValue = 1;
  bool selectedValueBool = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Make a transfer"),
      ),
      body: Center(
        child: (_futureTransfer == null)
            ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Creation Transfer Page"),
                DropdownButton(
                  value: selectedValue,
                  items: [
                    DropdownMenuItem(
                      child: Text("Immediate transfer"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Scheduled transfer"),
                      value: 2,
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                      if (selectedValue == 2) {
                        selectedValueBool = true;
                      } else {
                        selectedValueBool = false;
                      }
                    });
                  },
                ),
                digitTextField(controller: amountController, message: "Amount"),
                classicTextField(controller: emailReceiverController, message: "Email of the receiver"),
                classicTextField(controller: questionController, message: "Verification question"),
                classicTextField(controller: answerController, message: "Verification answer"),
                datePickerTextField(selectedValueBool: selectedValueBool, dateController: dateController),
                ElevatedButton(
                  onPressed: () {
                    testInputFilled(context);
                  },
                  child: Text("Validate"),
                )
              ])
            : futureBuilderTransfer(futureTransfer: _futureTransfer, selectedValueBool: selectedValueBool),
      ),
    );
  }

  void testInputFilled(dynamic context) {
    if (amountController.text == "") {
      ShowInformation().showMyDialog(context, "Amount Required.");
    } else if (emailReceiverController.text == "") {
      ShowInformation().showMyDialog(context, "Email Required.");
    } else if (answerController.text == "") {
      ShowInformation().showMyDialog(context, "Question Answer Required.");
    } else if (questionController.text == "") {
      ShowInformation()
          .showMyDialog(context, "Verification Question Required.");
    } else if (dateController.text == "" && selectedValueBool == true) {
      ShowInformation().showMyDialog(context, "Date Required.");
    } else {
      createTransfer(context);
    }
  }

  void createTransfer(dynamic context) {
    ShowInformation().showMyDialog(context, "Transfer Validated");
    setState(() {
      String transferType;
      if (selectedValueBool == true) {
        transferType = "Scheduled";
      } else {
        transferType = "Immediate";
      }
      _futureTransfer = JsonHttp().postRequestTransfer(
          int.parse(amountController.text),
          questionController.text,
          answerController.text,
          dateController.text,
          transferType);
    });
  }
}


