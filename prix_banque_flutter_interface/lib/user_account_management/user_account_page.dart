import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/authentification_management/user_model.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Builders/futureBuilderUserAccount.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Buttons/navigatorPopButton.dart';
import 'package:prix_banque_flutter_interface/utilitarian/json_http.dart';

class UserInfoPage extends StatelessWidget {
  static const name = "/userInfoPage";

  @override
  Widget build(BuildContext context) {
    Future<User> currentUser = JsonHttp()
        .getRequestUser(firebaseUser.FirebaseAuth.instance.currentUser.email);

    return Scaffold(
      appBar: AppBar(
        title: Text("User info :"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: FutureBuilderUserAccount(futureUser: currentUser),
              ),
            ),
            NavigatorPopButton(myMessage: "Back to main menu !")
          ],
        ),
      ),
    );
  }
}
