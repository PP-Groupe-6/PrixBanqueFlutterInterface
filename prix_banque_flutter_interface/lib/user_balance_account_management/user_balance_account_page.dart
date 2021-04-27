import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/user_balance_account_management/display_list_transactions.dart';
import 'package:prix_banque_flutter_interface/user_balance_account_management/transactions_model.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Buttons/navigatorPopButton.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicText.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;
import 'package:prix_banque_flutter_interface/utilitarian/json_http.dart';

TransactionList transactionListFromJson(String str) =>
    TransactionList.fromJson(json.decode(str));

class TransactionList {
  List<Transactions> transactions;

  TransactionList({
    this.transactions,
  });

  factory TransactionList.fromJson(Map<String, dynamic> json) =>
      TransactionList(
        transactions: List<Transactions>.from(
            json["transactions"].map((x) => Transactions.fromJson(x))),
      );
}

class BalancePage extends StatefulWidget {
  static const name = "/balancePage";

  @override
  _BalancePageState createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  dynamic currentAmount;
  firebaseUser.User user = firebaseUser.FirebaseAuth.instance.currentUser;
  Future<TransactionList> futureTransactions;
  void initState() {
    super.initState();
    JsonHttp().getAmount(user.uid).then((futureAmount) => setState(() {
          currentAmount = futureAmount;
        }));
    futureTransactions = JsonHttp()
        .getTransactions(firebaseUser.FirebaseAuth.instance.currentUser.uid);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("My Transactions"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            classicText(
                myColor: Theme.of(context).primaryColor,
                myFontSize: 25,
                myText: "Transaction Page"),
            Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 2,
                child: FutureBuilder<TransactionList>(
                  future: futureTransactions,
                  //rootBundle.loadString('test_transactions.json'),
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    if (snap.hasData) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DisplayListTransaction(
                              transactions: snap.data.transactions,
                              color: Colors.blue,
                            )
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Text("No transactions found"),
                      );
                    }
                  },
                )
                //FutureBuilderTransaction(futureTransaction: currentTransaction),
                ),
            classicText(
                myColor: Theme.of(context).primaryColor,
                myFontSize: 50,
                myText: "Money balance : "),
            classicText(
              myColor: Theme.of(context).accentColor,
              myFontSize: 40,
              myText: "\$" "$currentAmount",
            ),
            NavigatorPopButton(myMessage: "Back to main menu !")
          ],
        ),
      ),
    );
  }
}
