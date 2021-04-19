import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/invoice_package/display_group_list_invoices.dart';

import 'invoice.dart';
import 'invoice_creation_dialog.dart';


// Body of the Invoice Management page
class InvoiceContent extends StatefulWidget {
  final InvoiceList invoicesReceived;
  final InvoiceList invoicesSent;

  InvoiceContent({Key key, @required this.invoicesReceived,@required this.invoicesSent}):super(key:key);

  @override
  _InvoiceContentState createState() => _InvoiceContentState();
}

// State
class _InvoiceContentState extends State<InvoiceContent> {

  // Represents which invoice list display (True = invoices created by user)
  bool displayClientOwnInvoices = false;

  // Payment of an invoice
  // Call back end to update the state
  // Update invoiceList
  void _updateListToPay(Invoice invoice){
    // http update
    widget.invoicesReceived.updateListToPay(invoice);
    setState(() {});
  }

  // Suppression of an invoice
  // Call back end to remove the invoice
  // Remove from invoiceList
  void _removeExpiredInvoice(Invoice invoice){
    //http update
    widget.invoicesSent.removeExpiredInvoice(invoice);
    setState(() {});
  }


  //Creation of an invoice
  // Call back end to create the invoice
  // Get the new invoice with all info
  // Add invoice to invoiceList
  void createInvoice(String clientName, int amount, DateTime expirationDate){
    // TODO
    // http post/get
    print("called");
  }

  // Display panel with fields to create an invoice
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,// user must tap button!
      builder: (BuildContext context) {
        return InvoiceCreationDialog(
          buttonFonction: createInvoice,
        );
      },
    );
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
              Container(
                margin: EdgeInsets.only(top: 20,bottom: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: DropdownButton(
                        value: displayClientOwnInvoices,
                        icon: const Icon(Icons.arrow_circle_down),
                        onChanged: (bool newValue){
                          setState(() {
                            displayClientOwnInvoices = newValue;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: true,
                            child: Text("Invoices sent"),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text("Invoices received"),
                          ),
                        ]
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 150,
                      margin: EdgeInsets.only(left: 20),
                      child: ElevatedButton(
                        child: Text("Create new invoice"),
                        onPressed: (){
                          _showMyDialog();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 10,
                color: Colors.blue,
              ),
              (displayClientOwnInvoices)?
              DisplayInvoicesSent(
                invoicesSent: widget.invoicesSent,
                onChange: _removeExpiredInvoice,
              ):
              DisplayInvoicesReceived(
                invoicesReceived: widget.invoicesReceived,
                onChange: _updateListToPay,
              )
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
    Future<Map<String, String>> loadJson() async {
      final jsonA = await DefaultAssetBundle.of(context).loadString('test_invoices.json');
      final jsonB = await DefaultAssetBundle.of(context).loadString('test_invoices_sent.json');
      return {
        'fileA': jsonA,
        'fileB': jsonB,
      };
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice management"),
      ),
      body: FutureBuilder(
        future: loadJson(),
        builder: (BuildContext context, AsyncSnapshot snap){
          if (snap.hasData){
            var invoiceListReceived = invoiceListFromJson(snap.data['fileA']);
            var invoiceListSent = invoiceListFromJson(snap.data['fileB']);
            return InvoiceContent(
              invoicesReceived: invoiceListReceived,
              invoicesSent: invoiceListSent,
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