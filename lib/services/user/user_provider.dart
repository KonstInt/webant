import 'dart:convert';
import 'dart:io';
import 'package:flutter_webant/local_storage/hive_save.dart';
import 'package:flutter_webant/models/client_get.dart';
import 'package:flutter_webant/models/client_post.dart';
import 'package:flutter_webant/models/user_get.dart';
import 'package:flutter_webant/services/user/client_provider.dart';
import 'package:flutter_webant/services/user/token_provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../constants.dart';

class UserProvider {
  static Future<UserGet> getUser(String username, String password,
      ClientPost clientPost, String type) async {
    final UserGet user;
    final String adress = 'http://gallery.dev.webant.ru/api/users/current';
    if (Constants.token == '' ||
        Constants.refreshToken == '' ) {
      final ClientGet client = await ClientProvider.getClient(clientPost);
      await TokenProvider.getToken(client, username, password, type);
    }
    if(type == 'refresh_token'){
      if(Constants.client.secret == '')
        await ClientProvider.getClient(clientPost);
      await TokenProvider.getToken(Constants.client, username, password, type);
    }
    try {
      final response = await http.get(Uri.parse(adress), headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer ${Constants.token}'
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body); 
        print('Ok');
        user = UserGet.fromMap(json);
        HiveSave.FullSave(user, password, Constants.token, Constants.refreshToken, true, Constants.client);
        Constants.currentUser = user;
        Constants.currentUser.birthday = DateFormat('dd.MM.yyyy').format(DateTime.parse(Constants.currentUser.birthday));
        return user;
      }
      if (response.statusCode == 401) {
        return getUser(username, Constants.refreshToken, clientPost, 'refresh_token');
      } else {
        throw ('Not 200 or 401');
      }
    } on SocketException catch (_) {
      throw (SocketException);
    }
  }
}
