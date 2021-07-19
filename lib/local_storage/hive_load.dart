import 'package:flutter_webant/models/client_get.dart';
import 'package:flutter_webant/models/user_get.dart';
import 'package:hive/hive.dart';

class HiveLoad {
  static Future<UserGet> getUser() async {
    var box = await Hive.openBox('Storage');
    String json = box.get('current user') == null ? '' : box.get('current user');
    return UserGet.fromJson(json);
  }

  static Future<ClientGet> getClient() async {
    var box = await Hive.openBox('Storage');
    String json = box.get('client') == null ? '' : box.get('client');
    return ClientGet.fromJson(json);
  }

  static Future<String> getPassword() async {
    var box = await Hive.openBox('Storage');
    return box.get('password') == null ? ' ' : box.get('password');
  }

  static Future<String> getToken() async {
    var box = await Hive.openBox('Storage');
    return box.get('token') == null ? ' ' : box.get('token');
  }

  static Future<String> getRefreshToken() async {
    var box = await Hive.openBox('Storage');
    return box.get('refreshToken') == null ? ' ' : box.get('refreshToken');
    
  }

  static Future<bool> getInSystem() async {
    var box = await Hive.openBox('Storage');
    int i = box.get('inSystem') == null ? 0 : box.get('inSystem');
    if (i == 1)
      return true;
    else
      return false;
    
  }


}
