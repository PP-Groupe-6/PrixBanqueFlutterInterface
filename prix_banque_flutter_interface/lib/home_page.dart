import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/show_information.dart';
import 'package:prix_banque_flutter_interface/transfers_management/transfer_main_page.dart';
import 'authentification_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const name = "/menuPage";

  final TextEditingController amountController = TextEditingController();

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
            Text(
              "Welcome",
              style: new TextStyle(fontSize: 90),
            ),
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
                  child: ElevatedButton(
                      onPressed: () {
                       Navigator.pushNamed(context, TransferPage.name);
                      },
                      child: Text("My transfers")),
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

                Text(
                  "Money amount : ",
                  style: new TextStyle(fontSize: 50),
                ),
                Text(
                  "3090",
                  style: new TextStyle(fontSize: 40),
                ),


              ],
            ),
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
