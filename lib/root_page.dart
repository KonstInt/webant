import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webant/constants.dart';
import 'package:flutter_webant/my_home_page.dart';
import 'package:flutter_webant/welcome_screen/screens/welcome_screen.dart';

import 'bloc/user_bloc/user_bloc.dart';

class RootPage extends StatefulWidget {
  String type;
  RootPage(this.type);
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(listener: (c, state) {
        ///*
        if (state is UserNotAccesState) {
          if (widget.type == 'auto') {
            //Constants.isInSystem = true;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => WelcomeScreen(),
              ),
              (route) => false,
            );
          } else {
           // Constants.isInSystem = true;
            Navigator.pop(context);
          }
        }

        if (state is UserLoadedState) {
          //Constants.isInSystem = true;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  MyHomePage(state.user, state.avatar, 0),
            ),
            (route) => false,
          );
        }
        if (state is UserNoInternetState) {
          //Constants.isInSystem = true;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  MyHomePage(state.user, state.avatar, 0),
            ),
            (route) => false,
          );
        }
        //*/
      }, builder: (context, state) {
        if (state is UserLoadingState) {
          return Center(
              child: CupertinoActivityIndicator());
        } else {
          return Center();
        }
      }),
    );
  }
}
