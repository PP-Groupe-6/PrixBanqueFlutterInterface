import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/transfers_management/transfer_model.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicText.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/pop-ups/show_information.dart';
import 'package:prix_banque_flutter_interface/utilitarian/json_http.dart';

class DisplayListTransfer extends StatefulWidget {
  final List<Transfer> transfers;
  final Color color;

  DisplayListTransfer({Key key, @required this.transfers, @required this.color})
      : super(key: key);

  @override
  _DisplayListTransfer createState() => _DisplayListTransfer();
}

class _DisplayListTransfer extends State<DisplayListTransfer> {
  String isTransferUpdated;

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
                  myText: "Waiting transfers",
                  myFontSize: 15,
                  myColor: Colors.white),
            ),
          ),
          Container(
            height: 300,
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).accentColor)),
            child: widget.transfers.isEmpty
                ? Center(
                    child: classicText(
                        myText: "No transfers found",
                        myFontSize: 15,
                        myColor: Colors.black),
                  )
                : ListView(
                    children: widget.transfers
                        .map(
                          (transfer) => ListTile(
                            title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  classicText(
                                      myFontSize: 15,
                                      myText:
                                          "From : ${transfer.mailAdressTransferPayer}"),
                                  classicText(
                                      myFontSize: 15,
                                      myText: "\$"
                                          "${transfer.transferAmount}"),
                                  classicText(
                                      myFontSize: 15,
                                      myText:
                                          "Date : ${transfer.executionTransferDate.substring(0, 10)}"),
                                ]),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              ShowInformation(onTransferAccepted: () async {
                                JsonHttp()
                                    .postTransferStatus(transfer.transferId)
                                    .then((futureString) => setState(() {
                                          isTransferUpdated = futureString;
                                        }));
                                await Future.delayed(
                                    Duration(milliseconds: 500));
                                if (isTransferUpdated == "true") {
                                  ShowInformation().showMyDialog(
                                      context, "Transfer accepted");
                                  widget.transfers.remove(transfer);
                                } else {
                                  ShowInformation().showMyDialog(context,
                                      "Not enough money");
                                }
                                setState(() {});
                              }).confirmDialog(
                                  context,
                                  transfer.receiverQuestion,
                                  transfer.receiverAnswer);
                            },
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
