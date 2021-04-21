import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prix_banque_flutter_interface/authentification_management/user_model.dart';
import 'package:prix_banque_flutter_interface/utilitarian/Widgets/Texts/classicRichText.dart';
import '../Texts/classicText.dart';

class FutureBuilderUserAccount extends StatelessWidget {
  const FutureBuilderUserAccount({
    Key key,
    @required Future<User> futureUser,
  })  : _futureUser = futureUser,
        super(key: key);

  final Future<User> _futureUser;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                classicText(
                    myColor: Theme.of(context).primaryColor,
                    myFontSize: 35,
                    myText: "User account information :"),
                Center(
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.blue,
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          height: 100,
                          child: Icon(
                            Icons.account_circle_outlined,
                            color: Theme.of(context).primaryColor,
                            size: 100,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            classicRichText(
                                myText: "Mail Adress : ",
                                snapshot: snapshot.data.mailAdress),
                            classicRichText(
                                myText: "Full Name : ",
                                snapshot: snapshot.data.fullName),
                            classicRichText(
                                myText: "Phone Number : ",
                                snapshot: snapshot.data.phoneNumber),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }
}
