import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/authentification_management/user_model.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Buttons/verificationMailAdressButton.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/visibleRichText.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicRichText.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/visibleRichText.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/pop-ups/show_information.dart';
import '../Texts/classicText.dart';

class futureBuilderUser extends StatelessWidget {

  const futureBuilderUser({
    Key key,
    @required Future<User> futureUser,
  }) : _futureUser = futureUser, super(key: key);

  final Future<User> _futureUser;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                classicText(myColor: Theme.of(context).primaryColor, myFontSize: 24,myText: "User Account recap :"),
                Card(
                  elevation: 5,
                  shadowColor:Theme.of(context).primaryColor,
                  child: Column(
                    children: [
                      classicRichText(myText: "Mail Adress : ", snapshot: snapshot.data.mailAdress),
                      classicRichText(myText: "Password : ", snapshot: snapshot.data.password),
                      classicRichText(myText: "Full Name : ", snapshot: snapshot.data.fullName),
                      classicRichText(myText: "Phone Number : ", snapshot: snapshot.data.phoneNumber),
                    ],
                  ),
                ),
                ElevatedButton(onPressed: () {Navigator.pop(context);}, child: Text("Continue to Sign In")),
                verificationMailAdress(user : firebaseUser.FirebaseAuth.instance.currentUser),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }
}





