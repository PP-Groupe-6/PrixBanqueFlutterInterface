
import 'package:flutter/material.dart';

import 'authentification_service.dart';

import 'package:provider/provider.dart';


class HomePage extends StatelessWidget {
  static const name = "/menuPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("HOME"),
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