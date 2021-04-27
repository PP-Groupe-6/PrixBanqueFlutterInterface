import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InvoiceCreationDialog extends StatefulWidget{
  final Function(String, int, DateTime) buttonFonction;

  const InvoiceCreationDialog({Key key, this.buttonFonction}) : super(key: key);
  @override
  _InvoiceCreationDialogState createState() => _InvoiceCreationDialogState();
}

class _InvoiceCreationDialogState extends State<InvoiceCreationDialog> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  DateTime expirationDate;


  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != expirationDate)
      setState(() {
        expirationDate = picked;
      });
  }

  @override
  Widget build(BuildContext context){
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width - 100,
        height: MediaQuery.of(context).size.height - 100,
        margin: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Invoice Creation",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24,
              ),
            ),
            Divider(
              height: 10,
              color: Colors.blue,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Client's email",
              ),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                labelText: "Amount",
              ),
            ),
            Container(
              margin: EdgeInsets.only(top :20),
              child: Row(
                children: [
                  Text(
                    "Expiration Date : "
                  ),
                  Text(
                    (expirationDate==null)?" date not selected ":expirationDate.toString(),
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5)
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text("Select expiration date")
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () => widget.buttonFonction(emailController.text.trim(),int.parse(amountController.text.trim()),expirationDate),
                child: Text("Confirm creation")
            ),
          ],
        ),
      ),
    );
  }
}