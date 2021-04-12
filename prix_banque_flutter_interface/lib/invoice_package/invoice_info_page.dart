import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/invoice_package/invoice_main_page.dart';

class InvoiceInfo extends StatelessWidget{
  final Invoice invoice;

  InvoiceInfo({Key key, @required this.invoice}):super(key:key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice from "+invoice.clientToPay),
      ),
      body: Column(
        children: [
          Text("Invoice to pay before"+invoice.expirationDate.toString()),
          Text("Amount of the invoice : "+invoice.amount.toString()),
        ],
      )
    );
  }

}