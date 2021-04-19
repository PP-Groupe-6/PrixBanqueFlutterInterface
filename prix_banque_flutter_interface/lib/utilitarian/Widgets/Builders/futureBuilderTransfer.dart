import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/transfers_management/transfer_model.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/visibleRichText.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicRichText.dart';
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
  dynamic fullNamePayer;
  String accountTransferPayerId = "";
  dynamic fullNameReciever;
  String accountTransferReceiverId = "";

  @override
  void initState() {
    super.initState();
  }

  void networkLoading() {
    JsonHttp()
        .getRequestUserFullName(accountTransferPayerId)
        .then((futurePayerName) => setState(() {
              fullNamePayer = futurePayerName;
            }));
    JsonHttp()
        .getRequestUserFullName(accountTransferReceiverId)
        .then((futureRecieverName) => setState(() {
              fullNameReciever = futureRecieverName;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Transfer>(
        future: widget._futureTransfer,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            accountTransferReceiverId =
                snapshot.data.accountTransferReceiverId.toString();
            accountTransferPayerId =
                snapshot.data.accountTransferPayerId.toString();
            if (fullNamePayer == null && fullNameReciever == null) {
              networkLoading();
            }
            //Recup les noms avec les ID via get Request
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
                          myText: "From : ", snapshot: fullNamePayer),
                      classicRichText(
                          myText: "To : ", snapshot: fullNameReciever),
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
                          snapshot: snapshot.data.executionTransferDate),
                      visibleRichText(
                        selectedValueBool: widget.selectedValueBool,
                        myText: "Scheduled Date : ",
                        snapshot: snapshot.data.scheduledTransferDate,
                      ),
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
