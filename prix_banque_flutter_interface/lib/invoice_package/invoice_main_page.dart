import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prix_banque_flutter_interface/invoice_package/invoice_info_page.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

InvoiceList invoiceListFromJson(String str) => InvoiceList.fromJson(json.decode(str));

class InvoiceList {
  List<Invoice> invoices;

  InvoiceList({ this.invoices,});

  factory InvoiceList.fromJson(Map<String, dynamic> json) => InvoiceList(
    invoices: List<Invoice>.from(json["invoices"].map((x) => Invoice.fromJson(x))),
  );
}

class Invoice {
  final int id;
  final int amount;
  final String state;
  final String expirationDate;
  final String clientToPay;
  final String email;
  final String phoneNumber;

  Invoice({this.id, this.amount, this.state, this.expirationDate, this.clientToPay, this.email, this.phoneNumber});

  factory Invoice.fromJson(Map<String, dynamic> json){
    return Invoice(
      id : json['id'] as int,
      amount: json['amount'] as int,
      state: json['state'] as String,
      expirationDate: json['expDate'] as String,
      clientToPay: json['payto'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone'] as String,
    );
  }
}
Future<String> loadAsset() async {
  return await rootBundle.loadString('test_invoices.json');
}

class InvoicePage extends StatelessWidget {
  static const name = "/invoicePage";







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your invoices"),
      ),
      body: FutureBuilder(
        future: rootBundle.loadString('test_invoices.json'),
        builder: (BuildContext context, AsyncSnapshot snap){
          if (snap.hasData){
            var invoiceList = invoiceListFromJson(snap.data);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.lime,
                title: Text("Invoices to pay")
              ),
              body: Column(
                children: invoiceList.invoices.map((invoice) => ListTile(
                    title : Text(invoice.clientToPay),
                    onTap : (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>InvoiceInfo(
                              invoice: invoice
                          ),
                        ),
                      );
                    },
                )
                ).toList(),
              ),
            );

          }
          else{
            return CircularProgressIndicator();
          }
        }
      )

    );
  }

}