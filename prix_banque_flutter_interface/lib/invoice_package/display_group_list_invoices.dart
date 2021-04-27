import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'display_list_invoices.dart';
import 'invoice.dart';

class DisplayInvoicesReceived extends StatelessWidget{

  final Function(Invoice) onChange;
  final InvoiceList invoicesReceived;

  DisplayInvoicesReceived({Key key,@required this.invoicesReceived, @required this.onChange});

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
          invoices: invoicesReceived.invoicesExpired,
          color: Colors.redAccent,
          onChange: onChange,
          isInvoiceSent: false,
        ),
        DisplayListInvoice(
          state: "Invoices to pay",
          invoices: invoicesReceived.invoicesToPay,
          color: Colors.deepOrangeAccent,
          onChange: onChange,
          isInvoiceSent: false,
        ),
        DisplayListInvoice(
          state: "Invoices paid",
          invoices: invoicesReceived.invoicesPaid,
          color: Colors.lightGreen,
          onChange: onChange,
          isInvoiceSent: false,
        ),
      ],
    );
  }
}


class DisplayInvoicesSent extends StatelessWidget{

  final Function(Invoice) onChange;
  final InvoiceList invoicesSent;

  DisplayInvoicesSent({Key key,@required this.invoicesSent, @required this.onChange});

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10,bottom: 20),
          child: Text(
            "Invoice you sent :",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 24,
            ),
          ),
        ),
        DisplayListInvoice(
          state: "Invoices expired",
          invoices: invoicesSent.invoicesExpired,
          color: Colors.redAccent,
          onChange: onChange,
          isInvoiceSent: true,
        ),
        DisplayListInvoice(
          state: "Invoices waiting for payment",
          invoices: invoicesSent.invoicesToPay,
          color: Colors.deepOrangeAccent,
          onChange: onChange,
          isInvoiceSent: true,
        ),
        DisplayListInvoice(
          state: "Invoices paid",
          invoices: invoicesSent.invoicesPaid,
          color: Colors.lightGreen,
          onChange: onChange,
          isInvoiceSent: true,
        ),
      ],
    );
  }
}