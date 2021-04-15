import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prix_banque_flutter_interface/transfers_management/transfer_model.dart';

class JsonHttp
{

  Future<Transfer> postRequestTransfer(String title) async {
    Map data = {'transferAmout' : title};
    String body = json.encode(data);
    final response = await http.post(
      //http://localhost:57141/#/
      //https://jsonplaceholder.typicode.com/transfers
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
      throw Exception('Failed to load album');
    }
  }
}
