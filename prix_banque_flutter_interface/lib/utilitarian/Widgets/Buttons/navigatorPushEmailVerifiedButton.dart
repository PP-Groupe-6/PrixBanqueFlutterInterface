import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/pop-ups/show_information.dart';

class navigatorPushMailButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if(emailVerified){
          Navigator.pushNamed(context, route);}
          else{
            ShowInformation().showMyDialog(context, "Please verified your email before access to this menu");
          }
        },
        child: Text(message)
    );
  }
}