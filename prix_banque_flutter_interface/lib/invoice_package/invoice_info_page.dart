import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'invoice.dart';

class InvoiceInfo extends StatelessWidget{
  final Invoice invoice;

  InvoiceInfo({Key key, @required this.invoice}):super(key:key);

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
                                      text: invoice.clientToPay,
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
                                        text: invoice.email,
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
                                        text: invoice.phoneNumber,
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
                ],
              ),
            ),
          ),
        ],
      )
    );
  }

}