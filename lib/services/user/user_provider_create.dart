import 'dart:convert';
import 'dart:io';
import 'package:flutter_webant/local_storage/hive_save.dart';
import 'package:flutter_webant/models/user/user_get.dart';
import 'package:flutter_webant/models/user/user_post.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class UserProviderCreate {
  static Future<UserGet> getUser(UserPost userPost, String password) async {
    UserGet user;
    final String adress =
        'http://gallery.dev.webant.ru/api/users';
    try {
      final response = await http.post(Uri.parse(adress), headers: {'accept': 'application/json', 'Content-Type': 'application/json'}, body: userPost.toJson());
      if (response.statusCode == 201) {
        
        var json = jsonDecode(response.body); //TODO: this
        print('OGGGGGGKKKKK');

        user = UserGet.fromMap(json);
        user.birthday = DateFormat('dd.MM.yyyy').format(DateTime.parse(user.birthday));
        HiveSave.saveUser(user.toJson());
        HiveSave.fullSave(user, password, '', '', true, null);
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
