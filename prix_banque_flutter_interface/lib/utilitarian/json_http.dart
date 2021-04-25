import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prix_banque_flutter_interface/authentification_management/user_model.dart';
import 'package:prix_banque_flutter_interface/transfers_management/transfer_model.dart';

class JsonHttp {
  String date;

  Future<Transfer> postRequestTransfer(
      String mailAdressTransferPayer,
      String mailAdressTransferReceiver,
      double transferAmount,
      String transferType,
      String receiverQuestion,
      String receiverAnswer,
      String executionTransferDate) async {
    Map data = {
      'mailAdressTransferPayer': mailAdressTransferPayer,
      'mailAdressTransferReceiver': mailAdressTransferReceiver,
      'transferAmount': transferAmount,
      'receiverQuestion': receiverQuestion,
      'receiverAnswer': receiverAnswer,
      'transferType': transferType,
      'executionTransferDate': executionTransferDate,
    };
    String body = json.encode(data);
    final response = await http.post(
      Uri.parse("https://retoolapi.dev/AsJ5uM/transferliste"),
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

  Future<List<Transfer>> getRequestAllTransfer(String idClient) async {
    final responsePaid = await http.get(Uri.parse(
        "https://retoolapi.dev/AsJ5uM/transferliste?accountTransferPayerId=$idClient"));
    final responseReceived = await http.get(Uri.parse(
        "https://retoolapi.dev/AsJ5uM/transferliste?accountTransferReceiverId=$idClient"));
    if (responsePaid.statusCode == 200 && responseReceived.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List jsonResponse =
          jsonDecode(responsePaid.body) + jsonDecode(responseReceived.body);
      //jsonResponse.sort((a,b) => a["executionDateTime"].compareTo(b["executionDateTime"]));
      return jsonResponse.map((data) => new Transfer.fromJson(data)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load transfer');
    }
  }

  Future<List<Transfer>> getRequestReceivedTransfer(String idClient) async {
    final response = await http.get(Uri.parse(
        "https://retoolapi.dev/AsJ5uM/transferliste?accountTransferPayerId=$idClient"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => new Transfer.fromJson(data)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load transfer');
    }
  }

  Future<User> postRequestUser(var clientId, String mailAdress,
      String fullName, String phoneNumber) async {
    Map data = {
      'clientId': clientId,
      'mailAdress': mailAdress,
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

  Future<User> getRequestUser(String mailAdress) async {
    final response = await http.get(Uri.parse(
        "https://retoolapi.dev/NKqUcO/prixbanquetest?mailAdress=$mailAdress"));
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
}
