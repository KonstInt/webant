import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_webant/interceptor/auth2_interceptor.dart';
import 'package:flutter_webant/local_storage/hive_load.dart';
import 'package:flutter_webant/models/user/client/client_get.dart';
import 'package:flutter_webant/models/user/user_get.dart';
import 'package:flutter_webant/services/user/client_provider.dart';
import 'package:flutter_webant/services/user/token_provider.dart';
import 'package:intl/intl.dart';

class UserProvider {
  static Future<UserGet> getUser(
      String username, String password, String type) async {
    final String adress = 'http://gallery.dev.webant.ru/api/users/current';
    String token = await HiveLoad.getToken();
    String refreshToken = await HiveLoad.getRefreshToken();
    ClientGet client = await HiveLoad.getClient();
    if (token == '' || refreshToken == '') {
      final ClientGet client = await ClientProvider.getClient();
      await TokenProvider.getToken(client, username, password, type);
    }
    if (type == 'refresh_token') {
      if (client.secret == '') await ClientProvider.getClient();
      await TokenProvider.getToken(client, username, password, type);
    }
    try {
      String token = await HiveLoad.getToken();
      Dio dio = new Dio();
      dio.interceptors.add(TokenInterceptor2(dio: dio));
      UserGet? model = await dio
          .get(adress,
              options: Options(headers: {
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.authorizationHeader: 'Bearer $token',
              }))
          .then((response) {
        if (response.statusCode == 200) {
          print('Ok');
          var user = UserGet.fromMap(response.data);
          user.birthday =
              DateFormat('dd.MM.yyyy').format(DateTime.parse(user.birthday));
          return user;
        }
      });
      return model != null ? model : throw ('not sucsess');
    } 
    catch (e) {
      if(e is DioError)
      {
          if(e.message.contains('SocketException'))
            throw (SocketException);
      }
      throw (e);
    } 
  }
}
