import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/invoice_package/invoice_info_page.dart';

import 'package:provider/provider.dart';

class Invoice {
  final String nameOfReceiver;
  final DateTime date;
  final int amount;

  Invoice(this.nameOfReceiver,this.date,this.amount);
}

class InvoicePage extends StatelessWidget {
  static const name = "/invoicePage";

  List<Invoice> invoices = List.generate(
      10,
      (index) => Invoice(
        "Person $index",
        DateTime.utc(2021,4,index),
        100,
      )
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your invoices"),
      ),
      body: ListView.builder(
          itemCount: invoices.length,
          itemBuilder: (context,index){
            return ListTile(
              title : Text(invoices[index].nameOfReceiver),
              onTap : (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context)=>InvoiceInfo(
                          invoice: invoices[index]
                        ),
                    ),
                );
              }
            );
          }
      )
    );
  }

}