import 'package:flutter_webant/models/photo/photo.dart';
import 'package:flutter_webant/models/user/client/client_get.dart';
import 'package:flutter_webant/models/user/user_get.dart';
import 'package:hive/hive.dart';

class HiveLoad {
  static Future<UserGet> getUser() async {
    var box = await Hive.openBox('Storage');
    String json = box.get('user') == null ? ' ' : box.get('user');
    if(json != ' ')
    return UserGet.fromJson(json);
    else
    return UserGet(id: 0, email: '', enabled: false, phone: '', fullName: '', username: '', birthday: '', roles: []);
  }

  static Future<ClientGet> getClient() async {
    var box = await Hive.openBox('Storage');
    String json = box.get('client') == null ? ' ' : box.get('client');
    if(json != ' ')
    return ClientGet.fromJson(json);
    else
    return ClientGet(id: 0, name: '', randomId: '', secret: '', allowedGrantTypes: []);
  }

  
  static Future<String> getAvatar() async {
    var box = await Hive.openBox('Storage');
    return box.get('avatar') == null ? '' : box.get('avatar');
  }

  static Future<String> getToken() async {
    var box = await Hive.openBox('Storage');
    return box.get('token') == null ? '' : box.get('token');
  }

  static Future<String> getRefreshToken() async {
    var box = await Hive.openBox('Storage');
    return box.get('refreshToken') == null ? '' : box.get('refreshToken');
    
  }

  static Future<bool> getInSystem() async {
    var box = await Hive.openBox('Storage');
    int i = box.get('inSystem') == null ? 0 : box.get('inSystem');
    if (i == 1)
      return true;
    else
      return false;
    
  }

  static Future<List<Photo>> getPhotos(type) async {
    var box = await Hive.openBox(type);
    List<Photo> photos = box.get('photos') != null ? box.get('photos') :[];
    return photos;

  }


}
