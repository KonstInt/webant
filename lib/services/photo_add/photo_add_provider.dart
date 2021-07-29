import 'dart:convert';
import 'dart:io';

import 'package:flutter_webant/models/photo/photo.dart';
import 'package:flutter_webant/models/photo_add/photo_post.dart';
import 'package:flutter_webant/models/user/client/client_post.dart';
import 'package:flutter_webant/services/photo_add/media_object_provider.dart';
import 'package:flutter_webant/services/user/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';

class PhotoAddProvider {
  static Future<Photo> postPhoto(PhotoPost photo, XFile? image) async {
    final String adress = 'http://gallery.dev.webant.ru/api/photos';
    try {
      var getObject = await MediaObjectProvider.postMediaObject(image!);
      int? id = getObject.id;
      photo.image = '/api/media_objects/$id';
      final response = await http.post(Uri.parse(adress),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${Constants.token}'
          },
          body: photo);
      if(response.statusCode == 201) {
        var json = jsonDecode(response.body); 
        print('Ok');
        return  Photo.fromJson(json);

      }
      if (response.statusCode == 401) {
         await UserProvider.getUser(
            Constants.currentUser.username,
            Constants.refreshToken,
            new ClientPost(
                name: 'flutter',
                allowedGrantTypes: ["password", "refresh_token"]),
            'refresh_token');
            return postPhoto(photo, image);
      } else {
        throw ('Not 200 or 401');
      }
    } 
    catch(e){
      throw(e);
    }
    on SocketException catch (_) {
      throw (SocketException);
    }
  }
}
