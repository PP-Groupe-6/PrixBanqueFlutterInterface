import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/pop-ups/show_information.dart';

class verificationMailAdress extends StatelessWidget {
  const verificationMailAdress({
    Key key,
    this.user,
  }) : super(key: key);

  final firebaseUser.User user;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {
      user.reload();
      if(!user.emailVerified){
        user.sendEmailVerification();
      }
      print(user.emailVerified);
      user.reload();
      ShowInformation().showMyDialog(context, "check your mail and refresh the page");
    }, child: Text("Clic here to check your mail adress !"));
  }
}
