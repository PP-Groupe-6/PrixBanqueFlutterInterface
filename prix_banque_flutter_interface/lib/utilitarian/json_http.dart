import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prix_banque_flutter_interface/authentification_management/user_model.dart';
import 'package:prix_banque_flutter_interface/transfers_management/transfer_model.dart';

class JsonHttp {
  Future<Transfer> postRequestTransfer(
      int transferAmount,
      String receiverQuestion,
      String receiverAnswer,
      String scheduledTransferDate,
      String transferType) async {
    Map data = {
      'transferAmount': transferAmount,
      'receiverQuestion': receiverQuestion,
      'receiverAnswer': receiverAnswer,
      'scheduledTransferDate': scheduledTransferDate,
      'transferType': transferType
    };
    String body = json.encode(data);
    final response = await http.post(
      Uri.parse("https://retoolapi.dev/Nx5F0M/test"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    if (response.statusCode == 201) {
      return Transfer.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create transfer.');
    }
  }

  Future<Transfer> getRequestTransfer() async {
    final response =
        await http.get(Uri.parse("https://retoolapi.dev/Nx5F0M/test"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Transfer.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load transfer');
    }
  }

  Future<User> postRequestUser(var clientId, String mailAdress, String password,
      String fullName, int phoneNumber) async {
    Map data = {
      'clientId': clientId,
      'mailAdress': mailAdress,
      'password': password,
      'fullName': fullName,
      'phoneNumber': phoneNumber
    };
    String body = json.encode(data);
    final response = await http.post(
      Uri.parse("https://retoolapi.dev/NKqUcO/prixbanquetest"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user.');
    }
  }

  Future<User> getRequestUser(String clientId) async {
    final response = await http
        .get(Uri.parse("https://retoolapi.dev/NKqUcO/prixbanquetest?clientId=$clientId"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map<String, dynamic> data = jsonDecode(response.body)[0];
      return User.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load user');
    }
  }

  getRequestUserFullName(String clientId) async {
    final response = await http
        .get(Uri.parse("https://retoolapi.dev/NKqUcO/prixbanquetest?clientId=$clientId"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map<String, dynamic> data = jsonDecode(response.body)[0];
      print(data);
      return data['fullName'];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load user');
    }
  }
}
