import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/authentification_management/authentification_service.dart';
import 'package:prix_banque_flutter_interface/home_page.dart';
import 'package:prix_banque_flutter_interface/invoice_package/invoice_main_page.dart';

import 'package:prix_banque_flutter_interface/authentification_management/sign_in_page.dart';
import 'package:prix_banque_flutter_interface/authentification_management/sign_up_page.dart';
import 'package:prix_banque_flutter_interface/transfers_management/creation_transfer_page.dart';
import 'package:prix_banque_flutter_interface/transfers_management/transfer_main_page.dart';
import 'package:prix_banque_flutter_interface/user_account_management/user_account_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

Map<int, Color> color = {
  50: Color.fromRGBO(27, 30, 75, .1),
  100: Color.fromRGBO(27, 30, 75, .2),
  200: Color.fromRGBO(27, 30, 75, .3),
  300: Color.fromRGBO(27, 30, 75, .4),
  400: Color.fromRGBO(27, 30, 75, .5),
  500: Color.fromRGBO(27, 30, 75, .6),
  600: Color.fromRGBO(27, 30, 75, .7),
  700: Color.fromRGBO(27, 30, 75, .8),
  800: Color.fromRGBO(27, 30, 75, .9),
  900: Color.fromRGBO(27, 30, 75, 1),
};
Map<int, Color> color2 =
{
  50:Color.fromRGBO(69,90,100,.1),
  100:Color.fromRGBO(69,90,100,.2),
  200:Color.fromRGBO(69,90,100,.3),
  300:Color.fromRGBO(69,90,100,.4),
  400:Color.fromRGBO(69,90,100,.5),
  500:Color.fromRGBO(69,90,100,.6),
  600:Color.fromRGBO(69,90,100,.7),
  700:Color.fromRGBO(69,90,100,.8),
  800:Color.fromRGBO(69,90,100,.9),
  900:Color.fromRGBO(69,90,100,1),
};

MaterialColor colorBlueCustom = MaterialColor(0xFF1B1E4B, color);
MaterialColor colorGreyCustom = MaterialColor(0xFF1B1E4B, color2);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        title: 'Prix Banque',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: colorBlueCustom,
          primaryColor: colorBlueCustom[900],
          hoverColor: colorBlueCustom[500],
          accentColor: colorGreyCustom[900],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
        routes: {
          SignInPage.name: (context) => SignInPage(),
          SignUpPage.name: (context) => SignUpPage(),
          HomePage.name: (context) => HomePage(),

          InvoicePage.name: (context) => InvoicePage(),

          TransferPage.name: (context) => TransferPage(),
          CreateTransferPage.name: (context) => CreateTransferPage(),
          UserInfoPage.name: (context) => UserInfoPage(),

        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return HomePage();
    }
    return SignInPage();
  }
}
