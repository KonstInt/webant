import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webant/bloc/full_screen_photo/full_screen_photo_bloc.dart';
import 'package:flutter_webant/models/photo/photo.dart';

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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: BlocBuilder<FullScreenPhotoBloc, FullScreenPhotoState>(
          builder: (context, state) {
            if (state is FullScreenPhotoLoadedState)
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Image(
                      image: CachedNetworkImageProvider(
                          Constants.webAdressForPicture +
                              widget.photo.image.name),
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
                    Row(
                      children: [
                        Expanded (
                                                  child: Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.symmetric(),
                            padding: EdgeInsets.all(10),
                            child: Text(widget.photo.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 25,
                                    color: Colors.black)),
                          ),
                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.centerLeft,
                          //margin: EdgeInsets.symmetric(vertical: 20),
                          padding: EdgeInsets.all(10),
                          child: Text(state.seens.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.grey[600])),
                        ),
                        Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.remove_red_eye,
                              color: Colors.grey[600],
                            ))
                      ],
                    ),
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          child: state.user != null
                              ? Text(state.user!.username,
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 15))
                              : Text(''),
                        ),
                        Spacer(),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(Constants.formatStr(widget.photo.date),
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 15)))
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(
                        horizontal: 12, vertical: 20
                      ),
                      
                      child: Text(widget.photo.description,
                          style: TextStyle(
                            fontSize: 15,
                          )),
                    ),
                  ],
                ),
              );
            if (state is FullScreenPhotoNoInternetState) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(Constants.noInternetPicturePath),
                  Text(
                    "No Data Connection Available.",
                  )
                ],
              ));
            }
            if (state is FullScreenPhotoLoadingState) {
              return Center(
                child: Text('Loading...'),
              );
            } else
              return Center(child: Text('Error'));
          },
        ));
  }
}
