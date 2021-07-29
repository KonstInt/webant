import 'package:flutter_webant/models/user/client/client_get.dart';
import 'package:flutter_webant/models/user/user_get.dart';
import 'package:hive/hive.dart';

class HiveSave{

  
    static FullSave(UserGet user, String password, String token, String refreshToken, bool inSystem, ClientGet? client) async {
     
     var box = await Hive.openBox('Storage');
     box.put('current user', user.toJson());
     box.put('password', password);
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

  static SaveTokens(String token, String refreshToken) async {
      var box = await Hive.openBox('Storage');
      box.put('token', token);
      box.put('refreshToken', refreshToken);
  }

  static SaveAvatar(String avatar) async {
    var box = await Hive.openBox('Storage');
    box.put('avatar', avatar);
  }
 

}