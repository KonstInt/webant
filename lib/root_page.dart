import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webant/constants.dart';
import 'package:flutter_webant/my_home_page.dart';

import 'bloc/user_bloc/user_bloc.dart';

class RootPage extends StatefulWidget {
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
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        return Center(
          child: (() {
            if (state is UserLoadingState) {
              return Center(child: CupertinoActivityIndicator());
            }
            if (state is UserLoadedState) {
              Constants.isInSystem = true;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MyHomePage(),
                ),
                (route) => false,
              );
            }
            if (state is UserNoInternetState) {
              Constants.isInSystem = true;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MyHomePage(),
                ),
                (route) => false,
              );
            }
            if (state is UserNotAccesState) {
              Constants.isInSystem = true;
              Navigator.pop(context);
            }
          }()),
        );
      }),
    );
  }
}
