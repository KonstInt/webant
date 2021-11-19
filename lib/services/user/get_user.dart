import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_webant/models/user/user_get.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class GetUser {
  static Future<UserGet?> getUser(String path) async {
    final String adress = 'http://gallery.dev.webant.ru' + path;
    try {
      final response = await http
          .get(Uri.parse(adress), headers: {'accept': 'application/json'});
      if (response.statusCode == 200) {
        try {
          var json = jsonDecode(response.body);
          print('OGGGGGGKKKKK');

          var user = UserGet.fromMap(json);
          user.birthday = Constants.formatStr(user.birthday);
          return user;
        } catch (_) {
          return null;
        }
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.

        return null;
      }
    } on SocketException catch (_) {
      return null;
    }
  }
}
