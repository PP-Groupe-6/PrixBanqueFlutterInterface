import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prix_banque_flutter_interface/transfers_management/transfer_model.dart';

class JsonHttp
{

  Future<Transfer> createTransfer(String title) async {
    Map data = {'transferAmout' : title};
    String body = json.encode(data);
    final response = await http.post(
      //http://localhost:57141/#/
      //https://jsonplaceholder.typicode.com/transfers
      Uri.parse("http://localhost:57141/#/createTransferPage"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    print(response.statusCode);
    if (response.statusCode == 201) {
      return Transfer.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create transfer.');
    }
  }
}
