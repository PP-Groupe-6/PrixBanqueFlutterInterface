import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/authentification_service.dart';
import 'package:prix_banque_flutter_interface/home_page.dart';
import 'package:prix_banque_flutter_interface/show_information.dart';
import 'package:prix_banque_flutter_interface/sign_up_page.dart';
import 'package:provider/provider.dart';

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
            children: [
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
              ElevatedButton(
                onPressed: () {
                  context.read<AuthenticationService>().signIn(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  ).then((message) {
                      ShowInformation().showMyDialog(context, message);
                  });
                },
                child: Text("Sign in"),

              ),

              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpPage.name);
                  },
                  child: Text("Sign Up")
              )
            ]
        )
    );
  }
}