import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prix_banque_flutter_interface/invoice_package/display_list_invoices.dart';

import 'invoice.dart';

class InvoicePage extends StatelessWidget {
  static const name = "/invoicePage";

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your invoices"),
      ),
      body: FutureBuilder(
        future: rootBundle.loadString('test_invoices.json'),
        builder: (BuildContext context, AsyncSnapshot snap){
          if (snap.hasData){
            var invoiceList = invoiceListFromJson(snap.data);
            return RawScrollbar(
              thumbColor: Colors.lightBlueAccent,
              thickness: 10.0,
              fadeDuration: Duration(seconds: 1),
              timeToFade: Duration(seconds: 2),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
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
                      ),
                      DisplayListInvoice(
                        state: "Invoices expired",
                        invoices: invoiceList.invoicesExpired,
                        color: Colors.deepOrangeAccent,
                      ),

                    ],
                  ),
                ),
              ),
            );

          }
          else{
            return Center(
                child: CircularProgressIndicator()
            );
          }
        }
      )

    );
  }

}