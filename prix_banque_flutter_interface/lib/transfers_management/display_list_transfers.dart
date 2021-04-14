import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/transfers_management/transfer_model.dart';

import '../show_information.dart';


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
            child: Text(
              "Waiting transfers",
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
        ),
        Container(
          height: 300,
          decoration: BoxDecoration(border: Border.all(color: widget.color)),
          child: widget.transfers.isEmpty
              ? Center(
                  child: Text(
                  "No transfers found",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ))
              : ListView(
                  children: widget.transfers
                      .map((transfer) => ListTile(
                            title: Text(transfer.accountTransferPayerId.toString()),
                            subtitle: Text(transfer.transferAmount.toString()),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              ShowInformation().confirmDialog(
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