import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prix_banque_flutter_interface/transfers_management/creation_transfer_page.dart';
import 'package:prix_banque_flutter_interface/transfers_management/display_list_transfers.dart';
import 'package:prix_banque_flutter_interface/transfers_management/transfer_model.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Buttons/navigatorPopButton.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Buttons/navigatorPushButton.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicText.dart';
import 'package:prix_banque_flutter_interface/utilitarian/json_http.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;


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

class TransferPage extends StatefulWidget {
  static const name = "/transferPage";

  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  Future<TransferList> futureTransfers;
  void initState(){
    super.initState();
    futureTransfers = JsonHttp().getWaitingTransfer(firebaseUser.FirebaseAuth.instance.currentUser.uid);

  }

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
              child: FutureBuilder<TransferList>(
                  future: futureTransfers, //rootBundle.loadString('test_transfers.json'),
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    if (snap.hasData) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DisplayListTransfer(
                              transfers: snap.data.transfers,
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
