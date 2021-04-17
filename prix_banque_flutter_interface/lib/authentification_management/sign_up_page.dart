
import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/authentification_management/authentification_service.dart';
import 'package:prix_banque_flutter_interface/authentification_management/user_model.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Builders/futureBuilderUser.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicText.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicTextField.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/digitTextField.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/pop-ups/show_information.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/obscureTextField.dart';
import 'package:prix_banque_flutter_interface/utilitarian/json_http.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  static const name = "/signUpPage";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordVerificationController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  var json = Map<String, String>();

  Future<User> _futureUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body:
      Center(
      child : (_futureUser == null) ?
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("images/PrixBanqueLogo.png"),
          classicText(myColor: Colors.black, myFontSize: 20, myText: "Let's start your adventure with us"),
          Container(
            child: Column(
              children:[
          classicTextField(controller: fullNameController, message: "Full Name"),
          classicTextField(controller: emailController, message: "Email"),
          obscureTextField(controller: passwordController, message: "Password"),
          obscureTextField(controller: passwordVerificationController, message: "Password Verification"),
          digitTextField(controller: phoneNumberController, message: "Phone Number"),]
            ),
          ),
          ElevatedButton(
            onPressed: () {
              testInputFilled(context);
            },
            child: Text("Sign Up"),
          )
        ],
      )
        : futureBuilderUser(futureUser: _futureUser),
    ));
  }

  void testInputFilled(BuildContext context){
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

  void userCreation(BuildContext context){
    context.read<AuthenticationService>().signUp( //Creation of user in Firebase
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((message) {
      if (message == "Signed up") {
        setState(() {

        //Creation of user in Database
        _futureUser = JsonHttp().postRequestUser(
            firebaseUser.FirebaseAuth.instance.currentUser.uid,
            emailController.text,
            passwordController.text,
            fullNameController.text,
            int.parse(phoneNumberController.text));
        });
        }
      else {
        ShowInformation().showMyDialog(context, message);
      }
    });
  }
}



