import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/transfers_management/transfer_model.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicText.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/pop-ups/show_information.dart';


class DisplayListTransfer extends StatefulWidget {

  final List<Transfer> transfers;
  final Color color;

  DisplayListTransfer(
      {Key key,
        @required this.transfers,
        @required this.color})
      : super(key: key);

  @override
  _DisplayListTransfer createState() => _DisplayListTransfer();
}

class _DisplayListTransfer extends State<DisplayListTransfer> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          children: [
            Container(
              color: widget.color,
              height: 30,
              child: Center(
                child: classicText(myText: "Waiting transfers", myFontSize: 15, myColor: Colors.black),
              ),
            ),
            Container(
              height: 300,
              decoration: BoxDecoration(border: Border.all(color: widget.color)),
              child: widget.transfers.isEmpty
                  ? Center(
                  child: classicText(myText: "No transfers found", myFontSize: 15, myColor: Colors.black),)
                  : ListView(
                children: widget.transfers
                    .map((transfer) => ListTile(
                  title: Text(transfer.accountTransferPayerId.toString()),
                  subtitle: Text(transfer.transferAmount.toString()),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    ShowInformation(onTransferAccepted : (){
                      widget.transfers.remove(transfer);
                      setState(() {
                      });
                    }).confirmDialog(
                        context,
                        transfer.receiverQuestion,
                        transfer.receiverAnswer);
                    },
                ))
                    .toList(),
              ),
            ),
          ],
        ));
  }
}
