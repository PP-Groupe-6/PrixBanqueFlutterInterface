import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;
import 'package:prix_banque_flutter_interface/transfers_management/transfer_main_page.dart';
import 'package:prix_banque_flutter_interface/user_account_management/user_account_page.dart';
import 'package:prix_banque_flutter_interface/user_balance_account_management/user_balance_account_page.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Buttons/navigatorPushButton.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Buttons/navigatorPushEmailVerifiedButton.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Buttons/verificationMailAdressButton.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicText.dart';
import 'package:prix_banque_flutter_interface/utilitarian/json_http.dart';
import 'authentification_management/authentification_service.dart';
import 'package:provider/provider.dart';

import 'invoice_package/invoice_main_page.dart';

class HomePage extends StatefulWidget {
  static const name = "/menuPage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String fullName;
  dynamic userName = "";
  double currentAmount;
  final TextEditingController amountController = TextEditingController();

  firebaseUser.User user = firebaseUser.FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    JsonHttp().getUserInformation(user.uid).then((futureUser) => setState(() {
          userName = futureUser.fullName;
        }));
    JsonHttp().getAmount(user.uid).then((futureAmount) => setState(() {
          currentAmount = futureAmount;
        }));
  }

  void onPopPage() {}

  @override
  Widget build(BuildContext context) {
    // On récupère le solde du compte

    return Scaffold(
      appBar: AppBar(
        title: Text("Main Menu"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            classicText(
                myColor: Colors.black,
                myFontSize: 90,
                myText: "Welcome $userName"),
            Image.asset("images/PrixBanqueLogo.png"),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 6,
                    height: 50,
                    child: navigatorPushMailButton(
                        route: BalancePage.name,
                        message: "My Bank Account",
                        emailVerified: user.emailVerified),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 6,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, InvoicePage.name)
                              .then((value) => setState(() {}));
                        },
                        child: Text("My invoices")),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 6,
                    height: 50,
                    child: navigatorPushMailButton(
                        route: TransferPage.name,
                        message: "My Transfers",
                        emailVerified: user.emailVerified),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 6,
                    height: 50,
                    child: navigatorPushButton(
                        route: UserInfoPage.name, message: "My user account"),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  classicText(
                      myColor: Theme.of(context).primaryColor,
                      myFontSize: 50,
                      myText: "Money balance : "),
                  classicText(
                      myColor: Theme.of(context).accentColor,
                      myFontSize: 40,
                      myText: "\$" "${currentAmount.toString()}"),
                ],
              ),
            ),
            Visibility(
              child: verificationMailAdress(user: user),
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
