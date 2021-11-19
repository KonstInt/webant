import 'package:flutter_webant/models/photo/photo.dart';
import 'package:flutter_webant/models/user/client/client_get.dart';
import 'package:flutter_webant/models/user/user_get.dart';
import 'package:hive/hive.dart';

class HiveSave{

  
    static fullSave(UserGet user, String token, String refreshToken, bool inSystem, ClientGet? client) async {
     
     var box = await Hive.openBox('Storage');
     box.put('current user', user.toJson());
     box.put('token', token);
     box.put('refreshToken', refreshToken);
     if(inSystem)
     box.put('inSystem', 1);
     else
     box.put('inSystem', 0); 
     if(client != null)
     box.put('client', client.toJson());
     box.close();
    }

  static saveTokens(String? token, String? refreshToken) async {
      var box = await Hive.openBox('Storage');
      if(token!=null)
      box.put('token', token);
      if(refreshToken!= null)
      box.put('refreshToken', refreshToken);
  }

  static saveAvatar(String avatar) async {
    var box = await Hive.openBox('Storage');
    box.put('avatar', avatar);
  }

  static saveUser(String user) async {
    var box = await Hive.openBox('Storage');
    box.put('user', user);
  }

  static saveClient(String client) async {
    var box = await Hive.openBox('Storage');
    box.put('client', client);
  }

  static savePhotos(List<Photo> photos, String type) async {
    var box = await Hive.openBox(type);
    box.put('photo', photos);
  }

 

}