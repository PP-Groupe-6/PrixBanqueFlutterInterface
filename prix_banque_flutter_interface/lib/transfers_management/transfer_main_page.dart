import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prix_banque_flutter_interface/transfers_management/creation_transfer_page.dart';
import 'package:prix_banque_flutter_interface/transfers_management/display_list_transfers.dart';
import 'package:prix_banque_flutter_interface/transfers_management/transfer_model.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Buttons/navigatorPopButton.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Buttons/navigatorPushButton.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicText.dart';

TransferList transferListFromJson(String str) =>
    TransferList.fromJson(json.decode(str));

class TransferList {
  List<Transfer> transfers;

  TransferList({
    this.transfers,
  });

  factory TransferList.fromJson(Map<String, dynamic> json) => TransferList(
        transfers: List<Transfer>.from(
            json["transfers"].map((x) => Transfer.fromJson(x))),
      );
}

class TransferPage extends StatelessWidget {
  static const name = "/transferPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Transfers"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            classicText(
                myColor: Theme.of(context).primaryColor,
                myFontSize: 25,
                myText: "Transfer Page"),
            navigatorPushButton(
              message: "Make a transfer",
              route: CreateTransferPage.name,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              child: FutureBuilder(
                  future: rootBundle.loadString('test_transfers.json'),
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    if (snap.hasData) {
                      var transferList = transferListFromJson(snap.data);
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DisplayListTransfer(
                              transfers: transferList.transfers,
                              color: Colors.blue,
                            )
                          ],
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
            NavigatorPopButton(myMessage: "Back to main menu !")
          ],
        ),
      ),
    );
  }
}
