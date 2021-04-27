import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prix_banque_flutter_interface/authentification_management/user_model.dart';
import 'package:prix_banque_flutter_interface/invoice_package/invoice.dart';
import 'package:prix_banque_flutter_interface/transfers_management/transfer_main_page.dart';
import 'package:prix_banque_flutter_interface/transfers_management/transfer_model.dart';
import 'package:prix_banque_flutter_interface/user_balance_account_management/transactions_model.dart';

class JsonHttp {
  String date;

  Future<List<Transactions>> getTransactions(String idClient) async {
    final response =
        await http.get(Uri.parse("http://localhost:8001/transfer/$idClient"));
    // "http://localhost:8001/transfer/$idClient"
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((data) => new Transactions.fromJson(data))
          .toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load transaction');
    }
  }

  Future<List<Transfer>> getWaitingTransfer(String idClient) async {
    final response = await http
        .get(Uri.parse("http://localhost:8001/transfer/waiting/$idClient"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List jsonResponse = jsonDecode(response.body);
      return null;//jsonResponse.map((data) => new TransferList().fromJson(data)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load transfer');
    }
  }

  Future<double> getAmount(String idClient) async {
    final response =
        await http.get(Uri.parse("http://localhost:8000/amount/$idClient"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map<String, dynamic> data = jsonDecode(response.body);
      double amount = double.parse(data["amount"]);
      return amount;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load amount');
    }
  }

  Future<User> getUserInformation(String idClient) async {
    final response =
        await http.get(Uri.parse("http://localhost:8000/users/$idClient"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map<String, dynamic> data = jsonDecode(response.body);
            return User.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load user');
    }
  }

  Future<Transfer> postTransfer(
      String mailAdressTransferPayer,
      String mailAdressTransferReceiver,
      String transferAmount,
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
      Uri.parse("http://localhost:8001/transfer/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': "*",
      },
      body: body,
    );
    if (response.statusCode == 200) {
      return Transfer.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create transfer.');
    }
  }

  Future<User> postUser(var clientId, String fullName, String phoneNumber,
      String mailAdress) async {
    Map data = {
      'clientId': clientId,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'mailAdress': mailAdress,
    };
    String body = json.encode(data);
    final response = await http.post(
      Uri.parse("http://localhost:8000/users/"),
      // http://localhost:8000/users/ https://retoolapi.dev/AsJ5uM/transferliste
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': "*",
      },
      body: body,
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      var user = User.fromJson(jsonDecode(response.body));
      print(response.body);
      return user;
    } else {
      throw Exception('Failed to create user.');
    }
  }

  Future<bool> postTransferStatus(var transferId) async {
    Map data = {
      'transferId': transferId,
    };
    String body = json.encode(data);
    final response = await http.post(
      Uri.parse("https://retoolapi.dev/NKqUcO/prixbanquetest"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': "*",
      },
      body: body,
    );
    if (response.statusCode == 201) {
      return (jsonDecode(response.body));
    } else {
      throw Exception('Failed to update Transfer.');
    }
  }

  Future<InvoiceList> getInvoiceList(String idClient, bool isInvoiceSent) async {
    final response = await http.get(Uri.parse("http://localhost:8002/invoices/$idClient?CreatedBy=$isInvoiceSent"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return InvoiceList.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to get list invoice');
    }
  }

  Future<bool> postInvoice(var clientId, String mailAdress, double amount, String expDate) async {
    Map data = {
      'uid': clientId,
      'emailClient': mailAdress,
      'amount': amount,
      'expDate': expDate
    };
    String body = json.encode(data);
    final response = await http.post(
      Uri.parse("http://localhost:8002/invoices/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['created'];
    } else {
      throw Exception('Failed to add invoice');
    }
  }

  Future<bool> postInvoicePayment(var invoiceId) async {
    Map data = {
      'Iid': invoiceId,
    };
    String body = json.encode(data);
    final response = await http.post(
      Uri.parse("http://localhost:8002/invoices/pay"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['paid'];
    } else {
      throw Exception('Failed to pay invoice');
    }
  }

  Future<bool> deleteInvoice(var invoiceId) async {
    Map data = {
      'Iid': invoiceId,
    };
    String body = json.encode(data);
    final response = await http.delete(
      Uri.parse("http://localhost:8002/invoices/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['deleted'];
    } else {
      throw Exception('Failed to delete invoice');
    }
  }


}
