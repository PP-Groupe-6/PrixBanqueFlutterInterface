import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/authentification_management/sign_up_page.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Buttons/authentificationButton.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Buttons/navigatorPushButton.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicTextField.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/obscureTextField.dart';

class SignInPage extends StatelessWidget {
  static const name = "/signInPage";
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign In"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("images/PrixBanqueLogo.png"),
              Container(
              child :Column (
                  children : [
                    classicTextField(controller: emailController, message: "Email"),
                    obscureTextField(controller: passwordController, message: "Password"),
                            ]
              )
              ),
              authentificationButton(emailController: emailController, passwordController: passwordController),
              navigatorPushButton(route :SignUpPage.name, message :"Sign Up"),
            ]
        )
    );
  }
}





