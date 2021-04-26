import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/utilitarian/json_http.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;
import 'display_list_invoices.dart';
import 'invoice.dart';
import 'invoice_creation_dialog.dart';


Future<Map<String, String>> loadJson(BuildContext context, bool isFromClient) async {
  String json;
  if (isFromClient){
    json = await DefaultAssetBundle.of(context).loadString('test_invoices_sent.json');
  }
  else {
    json = await DefaultAssetBundle.of(context).loadString('test_invoices.json');
  }
  return {
    'file': json,
  };
}


class InvoicePage extends StatefulWidget {
  static const name = "/invoicePage";

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {

  Future<InvoiceList> _futureInvoices;
  bool isInvoiceSent;
  final String uid = firebaseUser.FirebaseAuth.instance.currentUser.uid;

  @override
  void initState(){
    super.initState();
    isInvoiceSent=false;
    print(uid);
    _futureInvoices = JsonHttp().getInvoiceList(uid, isInvoiceSent);
  }

  // Payment of an invoice
  // Call back end to update the state
  // Update invoiceList
  void _invoicePayment(Invoice invoice){
    Future<bool> result = JsonHttp().postInvoicePayment(invoice.id);
    var done;
    result.then((value) => done=value);
    if(done){
      //getInvoiceList()
      print("paid");
      //Navigator.pop
      //set state
    }
    else{
      print("impossible to pay");
    }
  }

  // Suppression of an invoice
  // Call back end to remove the invoice
  // Remove from invoiceList
  Future<void> _removeExpiredInvoice(Invoice invoice) async {
    var result = await JsonHttp().deleteInvoice(invoice.id);
    if(result){
      //remove
      print("deleted");
      //Navigator.pop
      //set state
    }
    else{
      print("error in suppression");
    }
  }


  //Creation of an invoice
  // Call back end to create the invoice
  // Get the new invoice with all info
  // Add invoice to invoiceList
  void createInvoice(String clientMail, int amount, DateTime expirationDate){
    Future<bool> result = JsonHttp().postInvoice(firebaseUser.FirebaseAuth.instance.currentUser.email, clientMail, double.parse(amount.toString()), expirationDate.toString());
    var done;
    result.then((value) => done=value);
    if(done){
      //getInvoiceList
      print("added");
      //Navigator.push
      //set state
    }
    else{
      print("can't add");
    }
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice management"),
      ),
      body: RawScrollbar(
        thumbColor: Colors.lightBlueAccent,
        thickness: 10.0,
        fadeDuration: Duration(seconds: 1),
        timeToFade: Duration(seconds: 2),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20,bottom: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        child: DropdownButton(
                            value: isInvoiceSent,
                            icon: const Icon(Icons.arrow_circle_down),
                            onChanged: (bool newValue){
                              setState(() {
                                print("t");
                                isInvoiceSent = newValue;
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
                            print("tap button");
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
                FutureBuilder<InvoiceList>(
                  future: _futureInvoices,
                  builder: (context,snapshot){
                    if (snapshot.hasData){
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
                            invoices: snapshot.data.invoicesExpired,
                            color: Colors.redAccent,
                            onChange: _removeExpiredInvoice,
                            isInvoiceSent: isInvoiceSent,
                          ),
                          DisplayListInvoice(
                            state: (isInvoiceSent)?"Invoices waiting for payment":"Invoices to pay",
                            invoices: snapshot.data.invoicesToPay,
                            color: Colors.deepOrangeAccent,
                            onChange: _invoicePayment,
                            isInvoiceSent: isInvoiceSent,
                          ),
                          DisplayListInvoice(
                            state: "Invoices paid",
                            invoices: snapshot.data.invoicesPaid,
                            color: Colors.lightGreen,
                            onChange: null,
                            isInvoiceSent: isInvoiceSent,
                          ),
                        ],
                      );
                    }
                    else{
                      return Center(
                          child: CircularProgressIndicator()
                      );
                    }
                  }
                ),
              ],
            ),
      )

    )));
  }
}