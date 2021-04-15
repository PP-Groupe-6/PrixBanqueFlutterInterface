import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/transfers_management/transfer_model.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/visibleRichText.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicRichText.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/visibleRichText.dart';

import '../Texts/classicText.dart';

class futureBuilderTransfer extends StatelessWidget {

  const futureBuilderTransfer({
    Key key,
    @required Future<Transfer> futureTransfer,
    @required this.selectedValueBool,
  }) : _futureTransfer = futureTransfer, super(key: key);

  final Future<Transfer> _futureTransfer;
  final bool selectedValueBool;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Transfer>(
        future: _futureTransfer,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                classicText(myColor: Colors.blue, myFontSize: 24,myText: "Transfer recap :"),
                Card(
                  elevation: 5,
                  shadowColor: Colors.blue,
                  child: Column(
                    children: [
                      classicRichText(myText: "Amount : ", snapshot: snapshot),
                      classicRichText(myText: "Verification Question : ", snapshot: snapshot),
                      classicRichText(myText: "Verification Answer : ", snapshot: snapshot),
                      classicRichText(myText: "Transfer type : ", snapshot: snapshot),
                      visibleRichText(selectedValueBool: selectedValueBool, myText: "Scheduled Date : ", snapshot: snapshot,)
                    ],
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }
}





