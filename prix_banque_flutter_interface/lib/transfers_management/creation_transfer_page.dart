import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prix_banque_flutter_interface/utilitarian/JSON_storage.dart';

import '../show_information.dart';

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

  var json = Map<String,String>();

  int selectedValue = 1;
  bool selectedValueBool = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Make a transfer"),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          TextField(
            controller: amountController,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              labelText: "Amount",
            ),
          ),
          TextField(
            controller: emailReceiverController,
            decoration: InputDecoration(
              labelText: "Email of the receiver",
            ),
          ),
          TextField(
            controller: questionController,
            decoration: InputDecoration(
              labelText: "Verification question",
            ),
          ),
          TextField(
            controller: answerController,
            decoration: InputDecoration(
              labelText: "Question answer",
            ),
          ),
          TextField(
            enabled: selectedValueBool,
            controller: dateController,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(''))
            ],
            decoration: InputDecoration(
              labelText: "Date",
            ),
            onTap: () async {
              var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100));
              dateController.text = date.toString().substring(0, 10);
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (amountController.text == "") {
                ShowInformation().showMyDialog(context, "Amount Required.");
              } else if (emailReceiverController.text == "") {
                ShowInformation().showMyDialog(context, "Email Required.");
              } else if (answerController.text == "") {
                ShowInformation()
                    .showMyDialog(context, "Question Answer Required.");
              } else if (questionController.text == "") {
                ShowInformation()
                    .showMyDialog(context, "Verification Question Required.");
              } else if (dateController.text == "" &&
                  selectedValueBool == true) {
                ShowInformation().showMyDialog(context, "Date Required.");
              } else {
                ShowInformation().showMyDialog(context, "Transfer Validated");
                json = {"Amount" : amountController.text};
                JSONStorage().createFile(json, new Directory("transfers_management"), "test_virement_creation.json");
              }
            },
            child: Text("Validate"),
          )
        ]),
      ),
    );
  }
}
