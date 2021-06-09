import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_webant/models/photo.dart';
import 'package:connectivity/connectivity.dart';

class FullScreenImage extends StatefulWidget {
  Photo photo;

  FullScreenImage(this.photo);
  @override
  _FullScreenImageState createState() => _FullScreenImageState(photo);
}

class _FullScreenImageState extends State<FullScreenImage> {
  Photo photo;

  late StreamSubscription connectivitySubscription;

  late ConnectivityResult _previousResult;

  bool dialogshown = false;

  _FullScreenImageState(this.photo);
  Future<String> _findPath(String imageUrl) async {
    final cache = DefaultCacheManager();
    final file = await cache.getSingleFile(imageUrl);
    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: CachedNetworkImageProvider(
                  "http://gallery.dev.webant.ru/media/" + photo.image.name),
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                // Appropriate logging or analytics, e.g.
                // myAnalytics.recordError(
                //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
                //   exception,
                //   stackTrace,
                // );
                return  Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/no_internet.png'),
                              Text(
                                "No Data Connection Available.",
                              )
                            ]);
              },
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.all(10),
              child: Text(photo.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.purple[900])),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              padding: EdgeInsets.all(10),
              child: Text(photo.description,
                  style: TextStyle(
                    fontSize: 15,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
