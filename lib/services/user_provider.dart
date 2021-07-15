import 'dart:convert';
import 'dart:io';

import 'package:flutter_webant/models/client_get.dart';
import 'package:flutter_webant/models/client_post.dart';
import 'package:flutter_webant/models/token_get.dart';
import 'package:flutter_webant/models/user_get.dart';
import 'package:flutter_webant/services/client_provider.dart';
import 'package:flutter_webant/services/token_provider.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  static Future<UserGet> getUser(
      String username, String password, ClientPost clientPost) async {
    final UserGet user;
    final ClientGet client = await ClientProvider.getClient(clientPost);
    TokenGet tokenGet =
        await TokenProvider.getToken(client, username, password, 'password');
    final String adress = 'http://gallery.dev.webant.ru/api/users/current';

    try {
      final response = await http.get(Uri.parse(adress), headers: {
        'accept': 'application/json',
        'Authorization': 'bearer ${tokenGet.access_token}'
      });
      if (response.statusCode == 200) {
        // NzNlMTE0NTRhZDA0NmNhYmE2NDlkMzVkY2E2YTM0OGRmZmQ1ZmUyNWZkMWE1Mzc2ZDI5MmU0NGY5ZDUxMGJhOA
        var json = jsonDecode(response.body); //TODO: this
        print('OGGGGGGKKKKK');

        user = UserGet.fromJson(json);

        return user;
      }
      if (response.statusCode == 401) {
        TokenGet tokenGet2 = await TokenProvider.getToken(
            client, username, tokenGet.refresh_token, 'refresh_token');

        final response = await http.get(Uri.parse(adress), headers: {
          'accept': 'application/json',
          'Authorization': 'bearer ${tokenGet2.access_token}'
        });
        if (response.statusCode == 200) {
          // YjNiMTBmZmFkMzk1N2ZjNGNiYmIwYzE4M2JjYmJkYjlkM2QzZDczMTBjMmQ4YzYyNzk0NTUxNjMxZjI2OGVlMQ
          var json = jsonDecode(response.body); //TODO: this
          print('OGGGGGGKKKKK');

          user = UserGet.fromJson(json);

          return user;
        }
        else {
        // If the server did not return a 200 OK response,
        // then throw an exception.

        throw ('WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW');
      }
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
