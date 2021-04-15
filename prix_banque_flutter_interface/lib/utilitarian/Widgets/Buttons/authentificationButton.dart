import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/authentification_management/authentification_service.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/pop-ups/show_information.dart';
import 'package:provider/provider.dart';

class authentificationButton extends StatelessWidget {
  const authentificationButton({
    Key key,
    @required this.emailController,
    @required this.passwordController,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<AuthenticationService>().signIn(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ).then((message) {
          ShowInformation().showMyDialog(context, message);
        });
      },
      child: Text("Sign in"),
    );
  }
}