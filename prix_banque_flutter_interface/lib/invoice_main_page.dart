import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class InvoicePage extends StatelessWidget {
  static const name = "/invoicePage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Invoice Page"),
          ],
        ),
      ),
    );
  }

}