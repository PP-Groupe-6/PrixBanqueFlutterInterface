import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/transfers_management/transfer_model.dart';
import 'package:prix_banque_flutter_interface/user_balance_account_management/display_list_transactions.dart';
import 'package:prix_banque_flutter_interface/user_balance_account_management/user_balance_account_page.dart';

class FutureBuilderTransaction extends StatelessWidget {
  const FutureBuilderTransaction({
    Key key,
    @required Future<List<Transfer>> futureTransaction,
  })  : _futureTransaction = futureTransaction,
        super(key: key);

  final Future<List<Transfer>> _futureTransaction;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Transfer>>(
      future: _futureTransaction,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var transactionsList = snapshot.data;
          return DisplayListTransaction(
              transactions: transactionsList,
              color: Theme.of(context).primaryColor);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
