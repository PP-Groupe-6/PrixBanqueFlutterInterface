
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/authentification_service.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  static const name = "/signUpPage";
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: fullNameController,
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
            decoration: InputDecoration(
              labelText: "Password",
            ),
          ),
          TextField(
            controller: phoneNumberController,
            decoration: InputDecoration(
              labelText: "Phone Number",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthenticationService>().signUp(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
              );
              Navigator.pop(context);
            },
            child: Text("Sign Up"),
          )
        ],
      ),
    );
  }
}