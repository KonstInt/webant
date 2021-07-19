import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_webant/constants.dart';
import 'package:flutter_webant/models/photo.dart';
import 'package:http/http.dart' as http;

import '../main.dart';


class PhotosProvider {

  
  static Future<List<Photo>> getPhotos(String type, int page, String name) async {
    
  
    final List<Photo> photos = [];
    
    final String adress = 'http://gallery.dev.webant.ru/api/photos?$type=true&name=$name&page=$page&limit=20';
    try {
      final response = await http.get(
          Uri.parse(adress),
          headers: {'accept': 'application/json'});
      
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        var json = jsonDecode(response.body);
        print('OGGGGGGKKKKK');

        int i = 0;
        for (var x in json['data']) {
          Photo item = Photo.fromJson(x);
          photos.add(item);
          i++;
          //images.add(NetworkImage("http://gallery.dev.webant.ru/media/" +
          //                                      item.name));

        }

        print(photos.length);
        

        return photos;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.

        throw('WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW');
      }
    } on SocketException catch (_) {
      throw(SocketException);
    }
  }
}
