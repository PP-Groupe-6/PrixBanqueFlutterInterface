import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/show_information.dart';
import 'package:prix_banque_flutter_interface/transfers_management/creation_transfer_page.dart';

import 'package:provider/provider.dart';

class TransferPage extends StatelessWidget {
  String secretQuestion="apero ?";
  String secretAnswer="bien sur";

  static const name = "/transferPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Transfers"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Transfer Page"),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, CreateTransferPage.name);
                },
                child: Text("Make a tranfer")),
            ElevatedButton(
                onPressed: () {
                  ShowInformation().confirmDialog(
                      context, secretQuestion, secretAnswer);
                },
                child: Text("Accept a tranfer"))
          ],
        ),
      ),
    );
  }
}
