import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/invoice_package/invoice_info_page.dart';

import 'invoice.dart';

class DisplayListInvoice extends StatelessWidget {

  final String state;
  final List<Invoice> invoices;
  final Color color;

  DisplayListInvoice({Key key, @required this.state, @required this.invoices, @required this.color}):super(key:key);


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            color: color,
            height: 30,
            child: Center(
              child: Text(
                state,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          Container(
            height: 300,
            decoration: BoxDecoration(
                border: Border.all(color: color)
            ),
            child: invoices.isEmpty?Center(
              child: Text(
                  "No invoices found",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
              )
            ):
            ListView(
              children: invoices.map((invoice) => ListTile(
                title : Text(invoice.clientToPay),
                subtitle: Text(invoice.expirationDate),
                trailing: Icon(Icons.keyboard_arrow_right),
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
          ),
        ],
      )
    );




  }
}

