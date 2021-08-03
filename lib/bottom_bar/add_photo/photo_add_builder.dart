import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webant/bloc/photo_add_bloc/photo_add_bloc.dart';
import 'package:flutter_webant/welcome_screen/screens/welcome_screen.dart';

import '../../constants.dart';
import '../../my_home_page.dart';

class PhotoAddBuilder extends StatefulWidget {

  @override
  _PhotoAddBuilderState createState() => _PhotoAddBuilderState();
}

class _PhotoAddBuilderState extends State<PhotoAddBuilder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PhotoAddBloc, PhotoAddState>(listener: (c, state) {
        ///*
        if (state is PhotoAddNotAccesState) {
          
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => WelcomeScreen(),
              ),
              (route) => false,
            );
         
        }

        if (state is PhotoAddLoadedState) {
          Constants.isInSystem = true;
          /*Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => MyHomePage().,
            ),
            (route) => false,
          );*/
          Navigator.pop(context);
        }
        if (state is PhotoAddNoInternetState) {
          Constants.isInSystem = true;
          Navigator.pop(context);
        }
        //*/
      }, builder: (context, state) {
        if (state is PhotoAddLoadingState) {
          return Center(child: CupertinoActivityIndicator());
        } else {
          return Container();
        }
      }),
    );
  }
}