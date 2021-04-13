import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prix_banque_flutter_interface/invoice_package/display_list_invoices.dart';

import 'invoice.dart';

class InvoicePage extends StatelessWidget {
  static const name = "/invoicePage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your invoices"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: rootBundle.loadString('test_invoices.json'),
          builder: (BuildContext context, AsyncSnapshot snap){
            if (snap.hasData){
              var invoiceList = invoiceListFromJson(snap.data);
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DisplayListInvoice(
                    state: "Invoices to pay",
                    invoices: invoiceList.invoicesToPay,
                    color: Colors.redAccent,
                  ),
                  DisplayListInvoice(
                    state: "Invoices paid",
                    invoices: invoiceList.invoicesPaid,
                    color: Colors.lightGreen,
                  )
                ],
              );

            }
            else{
              return CircularProgressIndicator();
            }
          }
        ),
      )

    );
  }

}