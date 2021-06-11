import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webant/models/photo.dart';

import '../constants.dart';

class FullScreenImage extends StatelessWidget {
  Photo photo;
  FullScreenImage(this.photo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: CachedNetworkImageProvider(
                  Constants.webAdressForPicture + photo.image.name),
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(Constants.noInternetPicturePath),
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
