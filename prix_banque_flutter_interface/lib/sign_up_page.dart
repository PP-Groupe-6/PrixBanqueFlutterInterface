
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prix_banque_flutter_interface/authentification_service.dart';
import 'package:prix_banque_flutter_interface/show_information.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  static const name = "/signUpPage";
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordVerificationController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Column(
        children: [
          TextField(
            controller: fullNameController,
            keyboardType: TextInputType.text,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'))],
            decoration: InputDecoration(
              labelText: "Full Name",
            ),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Email",
            ),
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",

            ),
          ),
          TextField(
            controller: passwordVerificationController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password Verification",

            ),
          ),
          TextField(
            controller: phoneNumberController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: "Phone Number",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (fullNameController.text==""){
                ShowInformation().showMyDialog(context, "Full Name Required.");
              }
              else if (phoneNumberController.text==""){
                ShowInformation().showMyDialog(context, "Phone Number Required.");
              }
              else if (passwordController.text != passwordVerificationController.text){
                ShowInformation().showMyDialog(context, "Passwords are not the same.");
              }
              else {
                context.read<AuthenticationService>().signUp(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                ).then((message) {
                  if (message == "Signed up") {
                    Navigator.pop(context);
                  }
                  else {
                    ShowInformation().showMyDialog(context, message);
                  }
                });
              }
            },
            child: Text("Sign Up"),
          )
        ],
      ),
    );
  }

}

