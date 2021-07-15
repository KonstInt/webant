import 'dart:convert';
import 'dart:io';

import 'package:flutter_webant/models/client_get.dart';
import 'package:flutter_webant/models/client_post.dart';
import 'package:http/http.dart' as http;

class ClientProvider {
  static Future<ClientGet> getClient(ClientPost postClient) async {
    final ClientGet client;

    final String adress =
        'http://gallery.dev.webant.ru/api/clients';
    try {
      final response = await http.post(Uri.parse(adress),headers: {'accept': 'application/json', 'Content-Type': 'application/json'}, body: postClient.toJson());
      if (response.statusCode == 201) {
              var json = jsonDecode(response.body); 
        print('OGGGGGGKKKKK');

        client = ClientGet.fromMap(json);

        return client;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.

        throw ('WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW');
      }
    } on SocketException catch (_) {
      throw ('SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS');
    }
  }
}
