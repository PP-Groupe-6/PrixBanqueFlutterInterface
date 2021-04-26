import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/transfers_management/transfer_model.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/visibleRichText.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicRichText.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/visibleRichText.dart';
import 'package:prix_banque_flutter_interface/utilitarian/json_http.dart';

import '../Texts/classicText.dart';

class futureBuilderTransfer extends StatefulWidget {
  const futureBuilderTransfer({
    Key key,
    @required Future<Transfer> futureTransfer,
    @required this.selectedValueBool,
  })  : _futureTransfer = futureTransfer,
        super(key: key);

  final Future<Transfer> _futureTransfer;
  final bool selectedValueBool;

  @override
  _futureBuilderTransferState createState() => _futureBuilderTransferState();
}

class _futureBuilderTransferState extends State<futureBuilderTransfer> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Transfer>(
        future: widget._futureTransfer,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                classicText(
                    myColor: Theme.of(context).primaryColor,
                    myFontSize: 35,
                    myText: "Transfer recap :"),
                Card(
                  elevation: 5,
                  shadowColor: Colors.blue,
                  child: Column(
                    children: [
                      classicRichText(
                          myText: "From : ", snapshot: snapshot.data.mailAdressTransferPayer),
                      classicRichText(
                          myText: "To : ", snapshot: snapshot.data.mailAdressTransferReceiver),
                      classicRichText(
                          myText: "Amount : ",
                          snapshot: snapshot.data.transferAmount),
                      classicRichText(
                          myText: "Verification Question : ",
                          snapshot: snapshot.data.receiverQuestion),
                      classicRichText(
                          myText: "Verification Answer : ",
                          snapshot: snapshot.data.receiverAnswer),
                      classicRichText(
                          myText: "Transfer type : ",
                          snapshot: snapshot.data.transferType),
                      classicRichText(
                          myText: "Execution Date : ",
                          snapshot: snapshot.data.executionTransferDate.substring(0,10)),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Done !")),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }
}
