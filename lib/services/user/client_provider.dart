import 'dart:convert';
import 'dart:io';
import 'package:flutter_webant/constants.dart';
import 'package:flutter_webant/local_storage/hive_save.dart';
import 'package:flutter_webant/models/user/client/client_get.dart';
import 'package:flutter_webant/models/user/client/client_post.dart';
import 'package:http/http.dart' as http;

class ClientProvider {
  static Future<ClientGet> getClient() async {
    final ClientGet client;
    ClientPost postClient = new ClientPost(
                name: 'flutter',
                allowedGrantTypes: ["password", "refresh_token"]);
    final String adress = 'http://gallery.dev.webant.ru/api/clients';
    try {
      final response = await http.post(Uri.parse(adress),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: postClient.toJson());
      if (response.statusCode == 201) {
        var json = jsonDecode(response.body);
        print('Ok');
        client = ClientGet.fromMap(json);
        HiveSave.saveClient(client.toJson());
        return client;
      } else {
        throw ('Not 200 OK response client');
      }
    } on SocketException catch (_) {
      throw (SocketException);
    }
  }
}
