import 'package:flutter_webant/models/client_get.dart';
import 'package:flutter_webant/models/client_post.dart';
import 'package:flutter_webant/models/token_get.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'client_provider.dart';

class TokenProvider {
  static Future<TokenGet> getToken(
      ClientGet client, String username, String password, String type) async {
    final TokenGet token;
    final String adress;
    if (type == 'password')
      adress =
          'http://gallery.dev.webant.ru/oauth/v2/token?client_id=${client.id}_${client.randomId}&grant_type=password&username=$username&password=$password&client_secret=${client.secret}';
    else
      adress =
          'http://gallery.dev.webant.ru/oauth/v2/token?client_id=${client.id}_${client.randomId}&grant_type=refresh_token&refresh_token=$password&client_secret=${client.secret}';

    try {
      final response = await http
          .get(Uri.parse(adress), headers: {'accept': 'application/json'});
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print('OGGGGGGKKKKK');

        token = TokenGet.fromMap(json);

        return token;
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
