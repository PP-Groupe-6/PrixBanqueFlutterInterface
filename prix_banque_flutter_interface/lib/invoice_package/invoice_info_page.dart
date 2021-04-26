import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/authentification_management/user_model.dart';
import 'package:prix_banque_flutter_interface/utilitarian/json_http.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;
import 'invoice.dart';

class InvoiceInfo extends StatelessWidget{
  final Invoice invoice;
  final bool isInvoiceSent;
  final Function(Invoice) buttonFonction;

  InvoiceInfo({Key key, @required this.isInvoiceSent, @required this.invoice, @required this.buttonFonction}):super(key:key);

  Future<User> _futureUser = JsonHttp().getUserInformation(firebaseUser.FirebaseAuth.instance.currentUser.uid);

  Widget getButton() {
    switch(invoice.state){
      case "waiting":
        return (isInvoiceSent)?Text("Wait for payment"):Container(
            margin: EdgeInsets.only(top: 20),
            child: ElevatedButton(
                child: Text("Pay"),
                onPressed:
                    (){
                  buttonFonction(invoice);
                }
            ),
        );
        break;
      case "expired":
        return (isInvoiceSent)?Container(
          margin: EdgeInsets.only(top: 20),
          child: ElevatedButton(
              child: Text("Confirm suppression"),
              onPressed:
                  (){
                buttonFonction(invoice);
              }
          ),
        ):Text("Please contact the invoice sender");
        break;
      case "paid":
        return (isInvoiceSent)?Text("Invoice paid")
            :Text("You already paid this invoice");
        break;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice info :"),
      ),
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 30,right: 30,top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Invoice from :",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    child: FutureBuilder<User>(
                      future: _futureUser,
                      builder: (context,snapshot){
                        if(snapshot.hasData) {
                          return Card(
                            elevation: 5,
                            shadowColor: Colors.blue,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 70,
                                  height: 100,
                                  child: Icon(
                                    Icons.account_circle_outlined,
                                    color: Colors.blue,
                                    size: 50,
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: "Name : ",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16
                                        ),
                                        children: [
                                          TextSpan(
                                            text: (isInvoiceSent) ? snapshot
                                                .data.fullName : invoice
                                                .withClientName,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13
                                            ),
                                          )
                                        ]
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: "Email : ",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16
                                        ),
                                        children: [
                                          TextSpan(
                                            text: (isInvoiceSent) ? snapshot
                                                .data.mailAdress : invoice
                                                .withClientEmail,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13
                                            ),
                                          )
                                        ]
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: "Phone number : ",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16
                                        ),
                                        children: [
                                          TextSpan(
                                            text: (isInvoiceSent) ? snapshot
                                                .data.phoneNumber : invoice
                                                .withClientPhone,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13
                                            ),
                                          )
                                        ]
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }
                        else{
                          return Center(
                              child: CircularProgressIndicator()
                          );
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "To :",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.blue,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 70,
                            height: 100,
                            child: Icon(
                              Icons.account_circle_outlined,
                              color: Colors.blue,
                              size: 50,
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: "Name : ",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16
                                    ),
                                    children: [
                                      TextSpan(
                                        text: invoice.withClientName,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13
                                        ),
                                      )
                                    ]
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: "Email : ",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16
                                    ),
                                    children: [
                                      TextSpan(
                                        text: invoice.withClientEmail,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13
                                        ),
                                      )
                                    ]
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: "Phone number : ",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16
                                    ),
                                    children: [
                                      TextSpan(
                                        text: invoice.withClientPhone,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13
                                        ),
                                      )
                                    ]
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 10,
                    color: Colors.blue,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Limit date for payment :",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      invoice.expirationDate,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Amount :",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      invoice.amount.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  getButton(),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }

}