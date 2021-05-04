import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/invoice_package/invoice_info_page.dart';
import 'invoice.dart';

class DisplayListInvoice extends StatefulWidget {
  final String state;
  final List<Invoice> invoices;
  final Color color;
  final Function(Invoice) onChange;
  final bool isInvoiceSent;

  DisplayListInvoice(
      {Key key,
      @required this.isInvoiceSent,
      @required this.onChange,
      @required this.state,
      @required this.invoices,
      @required this.color})
      : super(key: key);

  @override
  _DisplayListInvoiceState createState() => _DisplayListInvoiceState();
}

class _DisplayListInvoiceState extends State<DisplayListInvoice> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        Container(
          color: widget.color,
          height: 30,
          child: Center(
            child: Text(
              widget.state,
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
        ),
        Container(
          height: 300,
          decoration: BoxDecoration(border: Border.all(color: widget.color)),
          child: widget.invoices.isEmpty
              ? Center(
                  child: Text(
                  "No invoices found",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ))
              : ListView(
                  children: widget.invoices
                      .map((invoice) => ListTile(
                            title: Text(invoice.withClientName),
                            subtitle: Text(invoice.expirationDate.substring(0,10)),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InvoiceInfo(
                                    isInvoiceSent: widget.isInvoiceSent,
                                    invoice: invoice,
                                    buttonFonction: widget.onChange,
                                  ),
                                ),
                              );
                            },
                          ))
                      .toList(),
                ),
        ),
      ],
    ));
  }
}
