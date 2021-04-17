import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/authentification_management/authentification_service.dart';
import 'package:prix_banque_flutter_interface/home_page.dart';
import 'package:prix_banque_flutter_interface/authentification_management/sign_in_page.dart';
import 'package:prix_banque_flutter_interface/authentification_management/sign_up_page.dart';
import 'package:prix_banque_flutter_interface/transfers_management/creation_transfer_page.dart';
import 'package:prix_banque_flutter_interface/transfers_management/transfer_main_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}
Map<int, Color> color =
{
  50:Color.fromRGBO(27,30,75,.1),
  100:Color.fromRGBO(27,30,75,.2),
  200:Color.fromRGBO(27,30,75,.3),
  300:Color.fromRGBO(27,30,75,.4),
  400:Color.fromRGBO(27,30,75,.5),
  500:Color.fromRGBO(27,30,75,.6),
  600:Color.fromRGBO(27,30,75,.7),
  700:Color.fromRGBO(27,30,75,.8),
  800:Color.fromRGBO(27,30,75,.9),
  900:Color.fromRGBO(27,30,75,1),
};

MaterialColor colorCustom = MaterialColor(0xFF1B1E4B, color);
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
          primarySwatch: colorCustom,
          //textTheme: ThemeData.light(),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
          routes: {
          SignInPage.name: (context) => SignInPage(),
          SignUpPage.name: (context) => SignUpPage(),
          HomePage.name: (context) => HomePage(),
          TransferPage.name: (context) => TransferPage(),
            CreateTransferPage.name: (context) => CreateTransferPage()
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
