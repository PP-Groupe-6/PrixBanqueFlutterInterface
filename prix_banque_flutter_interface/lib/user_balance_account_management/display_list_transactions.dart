import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/transfers_management/transfer_model.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicText.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;

class DisplayListTransaction extends StatefulWidget {
  final List<Transfer> transactions;
  final Color color;

  DisplayListTransaction(
      {Key key, @required this.transactions, @required this.color})
      : super(key: key);

  @override
  _DisplayListTransaction createState() => _DisplayListTransaction();
}

class _DisplayListTransaction extends State<DisplayListTransaction> {
  String fullName;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: 30,
            child: Center(
              child: classicText(
                  myText: "Balance", myFontSize: 15, myColor: Colors.white),
            ),
          ),
          Container(
            height: 300,
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).accentColor)),
            child: widget.transactions.isEmpty
                ? Center(
                    child: classicText(
                        myText: "No transactions found",
                        myFontSize: 15,
                        myColor: Colors.black),
                  )
                : ListView(
                    children: widget.transactions
                        .map((transactions) => ListTile(
                              title:
                              classicText(
                                myText: transactions.transferAmount.toString(),
                                myColor: firebaseUser.FirebaseAuth.instance
                                    .currentUser.uid ==
                                    transactions.accountTransferPayerId
                                    ? Colors.red
                                    : Colors.green,
                                myFontSize: 25,
                              ),
                              subtitle: classicText(
                                myText: transactions.executionTransferDate
                                    .toString(),
                                myFontSize: 10,
                              ),
                              trailing: Icon(Icons.keyboard_arrow_right),
                            ))
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
