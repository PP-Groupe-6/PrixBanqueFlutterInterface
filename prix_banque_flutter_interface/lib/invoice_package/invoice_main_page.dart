import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prix_banque_flutter_interface/invoice_package/display_list_invoices.dart';

import 'invoice.dart';

class InvoiceContent extends StatefulWidget {
  final InvoiceList allInvoices;

  InvoiceContent({Key key, @required this.allInvoices}):super(key:key);

  @override
  _InvoiceContentState createState() => _InvoiceContentState();
}

class _InvoiceContentState extends State<InvoiceContent> {

  Future<void> _updateListToPay(Invoice invoice){
    widget.allInvoices.updateListToPay(invoice);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                invoices: widget.allInvoices.invoicesToPay,
                color: Colors.redAccent,
                onChange: _updateListToPay,
              ),
              DisplayListInvoice(
                state: "Invoices paid",
                invoices: widget.allInvoices.invoicesPaid,
                color: Colors.lightGreen,
                onChange: _updateListToPay,
              ),
              DisplayListInvoice(
                state: "Invoices expired",
                invoices: widget.allInvoices.invoicesExpired,
                color: Colors.deepOrangeAccent,
                onChange: _updateListToPay,
              ),

            ],
          ),
        ),
      ),
    );
  }
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
            return InvoiceContent(
              allInvoices: invoiceList,
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