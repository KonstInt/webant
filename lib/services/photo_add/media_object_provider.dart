import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_webant/interceptor/auth2_interceptor.dart';
import 'package:flutter_webant/local_storage/hive_load.dart';
import 'package:flutter_webant/models/photo_add/media_object_add.dart';
import 'package:image_picker/image_picker.dart';

class MediaObjectProvider {
  static Future<MediaObjectAddModel> postMediaObject(XFile image) async {
    // String sendImage = await convert(image);

    String fileName = image.path.split('/').last;

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
      ),
    });
    String token = await HiveLoad.getToken();
    Dio dio = new Dio();
    dio.interceptors.add(TokenInterceptor2(dio: dio));
    MediaObjectAddModel? model = await dio
        .post("http://gallery.dev.webant.ru/api/media_objects",
            data: data,
            options: Options(headers: {
              HttpHeaders.acceptHeader: 'application/json',
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.authorizationHeader: 'Bearer $token',
            }))
        .then((response) {
      if (response.statusCode == 201) {
        print('Ok');
        return MediaObjectAddModel.fromMap(response.data);
      }
    }).catchError((error) => throw (error));
    return model != null ? model : throw ('not sucsess');
  }
}
