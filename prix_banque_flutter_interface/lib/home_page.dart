import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;
import 'package:prix_banque_flutter_interface/transfers_management/transfer_main_page.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Buttons/navigatorPushButton.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Buttons/navigatorPushEmailVerifiedButton.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Buttons/verificationMailAdressButton.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicText.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/pop-ups/show_information.dart';
import 'authentification_management/authentification_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const name = "/menuPage";
  final TextEditingController amountController = TextEditingController();
  firebaseUser.User user = firebaseUser.FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Menu"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            classicText(myColor: Colors.black, myFontSize: 90, myText: "Welcome"),
            Image.asset("images/PrixBanqueLogo.png"),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/5,
            child :Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/6,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        ShowInformation()
                            .showMyDialog(context, "Bank account page");
                      },
                      child: Text("My bank accounts")),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/6,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        ShowInformation()
                            .showMyDialog(context, "Invoices page");
                      },
                      child: Text("My invoices")),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/6,
                  height: 50,
                  child: navigatorPushMailButton(route: TransferPage.name,message: "My Transfers", emailVerified : user.emailVerified),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/6,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        ShowInformation()
                            .showMyDialog(context, "User account page");
                      },
                      child: Text("My user account")),
                ),
              ],
            ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
            child :Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                classicText(myColor: Colors.black, myFontSize: 50, myText: "Money amount : "),
                classicText(myColor: Colors.black, myFontSize: 40, myText: "3090"),
              ],
            ),
            ),
            Visibility(
              child: verificationMailAdress(user : user),
              visible: !user.emailVerified,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
              child: Text("Sign out"),
            ),
          ],
        ),
      ),
    );
  }
}
