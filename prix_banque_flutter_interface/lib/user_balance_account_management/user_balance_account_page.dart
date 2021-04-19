import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/transfers_management/transfer_model.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Builders/futureBuilderTransaction.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicText.dart';
import 'package:prix_banque_flutter_interface/utilitarian/json_http.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;

class BalancePage extends StatelessWidget {
  static const name = "/balancePage";

  @override
  Widget build(BuildContext context) {
    Future<List<Transfer>> currentTransaction =
        JsonHttp().getRequestPaidTransfer(firebaseUser.FirebaseAuth.instance.currentUser.uid);

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
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              child: FutureBuilderTransaction(
                  futureTransaction: currentTransaction),
            )
          ],
        ),
      ),
    );
  }
}
