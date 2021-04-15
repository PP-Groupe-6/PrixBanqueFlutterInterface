
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prix_banque_flutter_interface/authentification_management/authentification_service.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicTextField.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/digitTextField.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/pop-ups/show_information.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/obscureTextField.dart';
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
          classicTextField(controller: fullNameController, message: "Full Name"),
          classicTextField(controller: emailController, message: "Email"),
          obscureTextField(controller: passwordController, message: "Password"),
          obscureTextField(controller: passwordVerificationController, message: "Password Verification"),
          digitTextField(controller: phoneNumberController, message: "Phone Number"),
          ElevatedButton(
            onPressed: () {
              testInputFilled(context);
            },
            child: Text("Sign Up"),
          )
        ],
      ),
    );
  }


  void testInputFilled(dynamic context){
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
      userCreation(context);
    }
  }


  void userCreation(dynamic context){
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
}



