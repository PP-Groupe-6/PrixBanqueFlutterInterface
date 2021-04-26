import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'display_list_invoices.dart';
import 'invoice.dart';

class DisplayInvoices extends StatelessWidget{

  final Function(Invoice) onChange;
  final InvoiceList invoices;
  final bool isInvoiceSent;

  DisplayInvoices({Key key,@required this.invoices, @required this.onChange, @required this.isInvoiceSent});

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10,bottom: 20),
          child: Text(
            "Invoice you received from other clients :",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 24,
            ),
          ),
        ),
        DisplayListInvoice(
          state: "Invoices expired",
          invoices: invoices.invoicesExpired,
          color: Colors.redAccent,
          onChange: onChange,
          isInvoiceSent: isInvoiceSent,
        ),
        DisplayListInvoice(
          state: (isInvoiceSent)?"Invoices waiting for payment":"Invoices to pay",
          invoices: invoices.invoicesToPay,
          color: Colors.deepOrangeAccent,
          onChange: onChange,
          isInvoiceSent: isInvoiceSent,
        ),
        DisplayListInvoice(
          state: "Invoices paid",
          invoices: invoices.invoicesPaid,
          color: Colors.lightGreen,
          onChange: onChange,
          isInvoiceSent: isInvoiceSent,
        ),
      ],
    );
  }
}