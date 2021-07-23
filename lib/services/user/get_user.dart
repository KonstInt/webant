import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_webant/models/user_get.dart';

class GetUser {
  static Future<UserGet> getUser(String path) async {

    final String adress =
        'http://gallery.dev.webant.ru'+path;
   try {
      final response = await http.post(Uri.parse(adress), headers: {'accept': 'application/json'});
      if (response.statusCode == 200) {
        
        var json = jsonDecode(response.body); //TODO: this
        print('OGGGGGGKKKKK');

        var user = UserGet.fromMap(json) ;
        
        return user;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.

        throw ('WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW');
      }
    } on SocketException catch (_) {
      throw (SocketException);
    }
  }
}
