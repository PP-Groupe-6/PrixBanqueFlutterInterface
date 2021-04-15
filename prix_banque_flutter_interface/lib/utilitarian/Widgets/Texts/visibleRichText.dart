import 'package:flutter/cupertino.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicRichText.dart';

class visibleRichText extends StatelessWidget {
  const visibleRichText({
    Key key,
    @required this.selectedValueBool,
    @required this.myText,
    @required this.snapshot,
  }) : super(key: key);

  final bool selectedValueBool;
  final String myText;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: classicRichText(myText: myText,snapshot: snapshot),
      visible: selectedValueBool,
    );
  }
}