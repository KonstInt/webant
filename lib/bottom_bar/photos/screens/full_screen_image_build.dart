

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webant/bloc/full_screen_photo/full_screen_photo_bloc.dart';
import 'package:flutter_webant/bottom_bar/photos/screens/full_screen_image.dart';
import 'package:flutter_webant/models/photo.dart';

class FullScreenImageBuild extends StatefulWidget {
  
  Photo photo;
  FullScreenImageBuild(this.photo);
  @override
  _FullScreenImageBuildState createState() => _FullScreenImageBuildState();
}

class _FullScreenImageBuildState extends State<FullScreenImageBuild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: BlocProvider(
          create: (context) => FullScreenPhotoBloc()
            ..add(new FullScreenPhotoLoadEvent(widget.photo.user
                )),
          child:
          //df;dfd;f,d;
              //search
              FullScreenImage(widget.photo)
      ),
    );
  }
}