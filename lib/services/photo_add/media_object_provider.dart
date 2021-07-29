import 'dart:convert';
import 'dart:io';

import 'package:flutter_webant/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_webant/models/photo/photo.dart';
import 'package:flutter_webant/models/photo_add/media_object_add.dart';
import 'package:flutter_webant/models/user/client/client_post.dart';
import 'package:flutter_webant/services/user/user_provider.dart';
import 'package:flutter_webant/services/user/user_provider_create.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../constants.dart';

class MediaObjectProvider {
  static Future<MediaObjectAddModel> postMediaObject(XFile image) async {
    String sendImage = await convert(image);
    final String adress = 'http://gallery.dev.webant.ru/api/media_objects';
    try {
      final response = await http.post(Uri.parse(adress),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${Constants.token}',
          
          },
          body: sendImage);
      
      if(response.statusCode == 201) {
        var json = jsonDecode(response.body); 
        print('Ok');
        return  MediaObjectAddModel.fromMap(json);

      }
      if (response.statusCode == 401) {
         await UserProvider.getUser(
            Constants.currentUser.username,
            Constants.refreshToken,
            new ClientPost(
                name: 'flutter',
                allowedGrantTypes: ["password", "refresh_token"]),
            'refresh_token');
            return postMediaObject(image);
      }
      else {
        throw ('Not 200 or 401');
      }
    } on SocketException catch (_) {
      throw (SocketException);
    }
  }

  static Future<String> convert(XFile image) async {
    final bytes = await image.readAsBytes();

    return base64Encode(bytes);
  }
}
