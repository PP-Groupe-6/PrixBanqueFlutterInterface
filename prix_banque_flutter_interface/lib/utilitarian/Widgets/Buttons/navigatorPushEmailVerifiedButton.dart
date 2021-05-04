import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/pop-ups/show_information.dart';

class navigatorPushMailButton extends StatefulWidget {
  const navigatorPushMailButton({
    Key key,
    @required this.message,
    @required this.route,
    @required this.emailVerified,
  }) : super(key: key);

  final String route;
  final String message;
  final bool emailVerified;

  @override
  _navigatorPushMailButtonState createState() => _navigatorPushMailButtonState();
}

class _navigatorPushMailButtonState extends State<navigatorPushMailButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if(widget.emailVerified){
          Navigator.pushNamed(context, widget.route);}
          else{
            ShowInformation().showMyDialog(context, "Please verified your email before access to this menu");
          }
        },
        child: Text(widget.message)
    );
  }
}