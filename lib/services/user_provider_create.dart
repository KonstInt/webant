import 'dart:convert';
import 'dart:io';

import 'package:flutter_webant/models/client_post.dart';
import 'package:flutter_webant/models/user_get.dart';
import 'package:flutter_webant/models/user_post.dart';
import 'package:flutter_webant/services/token_provider.dart';
import 'package:http/http.dart' as http;

class UserProviderCreate {
  static Future<UserGet> getUser(UserPost userPost) async {
    UserGet user;
    final String adress =
        'http://gallery.dev.webant.ru/api/users';
    try {
      final response = await http.post(Uri.parse(adress), headers: {'accept': 'application/json', 'Content-Type': 'application/json'}, body: userPost.toJson());
      if (response.statusCode == 201) {
        
        var json = jsonDecode(response.body); //TODO: this
        print('OGGGGGGKKKKK');

        user = UserGet.fromMap(json) ;

        return user;
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
