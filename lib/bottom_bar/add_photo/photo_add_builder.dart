import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webant/bloc/photo_add_bloc/photo_add_bloc.dart';
import 'package:flutter_webant/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_webant/local_storage/hive_load.dart';
import 'package:flutter_webant/models/user/user_get.dart';
import 'package:flutter_webant/welcome_screen/screens/welcome_screen.dart';

import '../../constants.dart';
import '../../main.dart';
import '../../my_home_page.dart';
import '../../root_page.dart';

class PhotoAddBuilder extends StatefulWidget {
  @override
  _PhotoAddBuilderState createState() => _PhotoAddBuilderState();
}

class _PhotoAddBuilderState extends State<PhotoAddBuilder> {
  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Loaded'),
      ),
    );
  }

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
          //UserGet user = await HiveLoad.getUser();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => MyHomePage(state.user, state.avatar, 2),
            ),
            (route) => false,
          );
          //_showToast(context);
          //Navigator.pop(context, {'message': 'Loaded', 'error': false});
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Loaded!'),
            ),
          );
        }
        if (state is PhotoAddNoInternetState) {
          Constants.isInSystem = true;
          Navigator.pop(context);
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No intenet!'),
            ),
          );
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
