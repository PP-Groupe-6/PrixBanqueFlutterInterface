import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicText.dart';

void main() {
  testWidgets('app should work', (WidgetTester tester) async {
    await tester.pumpWidget(classicText(myColor: Colors.black,myFontSize: 20, myText: "Let's start your adventure with us"));

    final classicTextFinder = find.text("Let's start your adventure with us");

    expect(classicTextFinder, findsOneWidget);
  });
}

