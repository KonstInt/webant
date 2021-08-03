import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_webant/interceptor/auth2_interceptor.dart';
import 'package:flutter_webant/local_storage/hive_load.dart';
import 'package:flutter_webant/models/photo/photo.dart';
import 'package:flutter_webant/models/photo_add/photo_post.dart';
import 'package:flutter_webant/services/photo_add/media_object_provider.dart';
import 'package:image_picker/image_picker.dart';

class PhotoAddProvider {
  static Future<Photo> postPhoto(PhotoPost photo, XFile? image) async {
    final String adress = 'http://gallery.dev.webant.ru/api/photos';
    try {
      var getObject = await MediaObjectProvider.postMediaObject(image!);
      int? id = getObject.id;
      photo.image = '/api/media_objects/$id';
      Dio dio = new Dio();
      dio.interceptors.add(TokenInterceptor2(dio:dio));
      String token = await HiveLoad.getToken();
      Photo? model = await dio
          .post("http://gallery.dev.webant.ru/api/photos",
              data: photo.toMap(),
              options: Options(headers: {
                HttpHeaders.acceptHeader: 'application/json',
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.authorizationHeader: 'Bearer $token',
              }))
          .then((response) {
        if (response.statusCode == 201) {
          print('Ok');
          return Photo.fromJson(response.data);
        }
      }).catchError((error) => throw (error));
      return model != null ? model : throw ('not sucsess');
    } catch (e) {
      throw (e);
    } on SocketException catch (_) {
      throw (SocketException);
    }
  }
}
