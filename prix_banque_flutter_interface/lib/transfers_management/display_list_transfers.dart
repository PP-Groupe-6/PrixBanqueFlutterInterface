import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/transfers_management/transfer_model.dart';

import '../show_information.dart';

class _TransferListInherited extends InheritedWidget {
  _TransferListInherited({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  final DisplayListTransferState data;

  @override
  bool updateShouldNotify(_TransferListInherited oldWidget) {
    return true;
  }
}
class DisplayListTransfer extends StatefulWidget {

  final List<Transfer> transfers;
  final Color color;
  DisplayListTransfer(
      {Key key,
      @required this.transfers,
      @required this.color,
      this.child,
      })
      : super(key: key);

  final Widget child;


  @override
  _DisplayListTransfer createState() => _DisplayListTransfer();
  static DisplayListTransferState of(BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<_TransferListInherited>() as _TransferListInherited).data;
  }
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
                                  transfer.receiverAnswer,
                                  transfer);
                            },
                          ))
                      .toList(),
                ),
        ),
      ],
    ));
  }
}


class DisplayListTransferState extends State<DisplayListTransfer>{
  /// List of Items
  List<Transfer> transfers = <Transfer>[];

  /// Helper method to add an Item
  void removeTransfer(Transfer transfer){
    setState((){
      transfers.remove(transfer);
    });
  }

  @override
  Widget build(BuildContext context){
    return new _TransferListInherited(
      data : this,
      child : widget.child,
    );
  }
}