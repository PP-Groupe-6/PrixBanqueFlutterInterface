import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CreateTransferPage extends StatelessWidget {
  static const name = "/createTransferPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Make a transfer"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Creation Transfer Page"),]
        ),
      ),
    );
  }

}