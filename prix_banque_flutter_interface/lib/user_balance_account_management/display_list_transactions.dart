import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/user_balance_account_management/transactions_model.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicText.dart';

class DisplayListTransaction extends StatefulWidget {
  final List<Transactions> transactions;
  final Color color;

  DisplayListTransaction(
      {Key key, @required this.transactions, @required this.color})
      : super(key: key);

  @override
  _DisplayListTransaction createState() => _DisplayListTransaction();
}

class _DisplayListTransaction extends State<DisplayListTransaction> {
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
                        .map(
                          (transactions) => ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                classicText(
                                  myText: "\$"
                                      "${transactions.transactionAmount.toString()}",
                                  myColor: transactions.role == "payer"
                                      ? Colors.red
                                      : Colors.green,
                                  myFontSize: 25,
                                ),
                                classicText(
                                  myText:
                                      "Date : ${transactions.transactionDate.substring(0,10)}",
                                  myFontSize: 15,
                                ),
                                classicText(
                                    myFontSize: 20,
                                    myText: transactions.role == "payer"
                                        ? "To ${transactions.name}"
                                        : "From ${transactions.name}"),
                                classicText(
                                    myFontSize: 15,
                                    myText:
                                        "Type : ${transactions.transactionType}"),
                              ],
                            ),
                            trailing: Icon(transactions.role == "payer"
                                ? Icons.remove
                                : Icons.add),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                              side: BorderSide(color: Colors.black),
                            ),
                            onTap: () {},
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
