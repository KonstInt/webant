import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webant/models/photo.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../constants.dart';

class FullScreenImage extends StatefulWidget {
  Photo photo;
  int seens = 0;
  FullScreenImage(this.photo);

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    var photoInfo = FirebaseFirestore.instance
        .collection('photos')
        .doc(widget.photo.id.toString());

    Future<void> addSeenToPhoto() {
      return photoInfo
          .update(
            {
              'seens': FieldValue.increment(1),
            },
          )
          .then((value) => print("Sucsess"))
          .catchError((error) => photoInfo
              .set(
                {
                  'seens': FieldValue.increment(1),
                },
              )
              .then((value) => print("Sucsess"))
              .catchError((error) => print("Failed to add user: $error")));
    }

    addSeenToPhoto();

    if (widget.photo.user != '') {
      var userInfo =
          FirebaseFirestore.instance.collection('users').doc(widget.photo.user);
      Future<void> addSeenToUser() {
        // Call the user's CollectionReference to add a new user
        return userInfo
            .update({
              'seens': FieldValue.increment(1), // John Doe
            })
            .then((value) => print("Sucsess"))
            .catchError((error) => userInfo
                .set({
                  'seens': FieldValue.increment(1), // John Doe
                })
                .then((value) => print("Sucsess"))
                .catchError((error) => print("Failed to add user: $error")));
      }

      addSeenToUser();
    }

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
                  Constants.webAdressForPicture + widget.photo.image.name),
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
              child: Text(widget.photo.name,
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
              child: Text(widget.photo.description,
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
