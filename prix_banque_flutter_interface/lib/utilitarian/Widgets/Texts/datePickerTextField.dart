import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class datePickerTextField extends StatelessWidget {
  const datePickerTextField({
    Key key,
    @required this.selectedValueBool,
    @required this.dateController,
  }) : super(key: key);

  final bool selectedValueBool;
  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
    );
  }
}
