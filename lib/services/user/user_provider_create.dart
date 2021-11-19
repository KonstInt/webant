import 'dart:convert';
import 'dart:io';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_webant/local_storage/hive_save.dart';
import 'package:flutter_webant/models/user/user_get.dart';
import 'package:flutter_webant/models/user/user_post.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../constants.dart';

class UserProviderCreate {
  static Future<UserGet> getUser(UserPost userPost, String password) async {
    UserGet user;
    final String adress = 'http://gallery.dev.webant.ru/api/users';
    try {
      Dio dio = new Dio();
      UserGet? model = await dio
          .post(adress,
              data: userPost.toMap(),
              options: Options(headers: {
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.contentTypeHeader: 'application/json',
              }))
          .then((response) {
        if (response.statusCode == 201) {
          print('Ok');
          user = UserGet.fromMap(response.data);
          user.birthday = Constants.formatStr(user.birthday);
          HiveSave.saveUser(user.toJson());
          HiveSave.fullSave(user, password, '', true, null);
          return user;
        }
      }).catchError((error) => throw (error));
      return model != null ? model : throw ('not sucsess');
    } on SocketException catch (_) {
      throw (SocketException);
    } catch (e) {
      throw (e);
    }
  }
}
