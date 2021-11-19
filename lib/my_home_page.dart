import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_webant/constants.dart';
import 'package:flutter_webant/root_page.dart';
import 'package:flutter_webant/welcome_screen/screens/welcome_screen.dart';

import 'bloc/user_bloc/user_bloc.dart';
import 'bottom_bar/add_photo/photo_add.dart';
import 'bottom_bar/add_photo/photo_add2.dart';
import 'bottom_bar/add_photo/root_add.dart';
import 'bottom_bar/photos/photos2_holder.dart';
import 'bottom_bar/profile/screens/user_profile.dart';
import 'models/user/user_get.dart';

class MyHomePage extends StatefulWidget {
  //String titleInput;
  //String amountInput;
  UserGet user;
  String avatar;
  List<Widget> screens = [];
  int _currentIndex;
  MyHomePage(this.user, this.avatar, this._currentIndex) {
    screens = [PhotosHolder2(), PhotoAdd(), UserProfile(user, avatar)];
  }
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  bool dialogshown = false;

  //final tabs =
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: IndexedStack(
          index: widget._currentIndex,
          children: widget.screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          //` showSelectedLabels: false,
          // showUnselectedLabels: false,
          currentIndex: widget._currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Constants.svgHomeIcon,
              activeIcon: Constants.svgHomeIconActive,
              title: Padding(padding: EdgeInsets.all(0)),
            ),
            BottomNavigationBarItem(
              icon: Constants.svgCameraIcon,
              activeIcon: Constants.svgCameraIconActive,
              title: Padding(padding: EdgeInsets.all(0)),
            ),
            BottomNavigationBarItem(
              icon: Constants.svgProfileIcon,
              activeIcon: Constants.svgProfileIconActive,
              title: Padding(padding: EdgeInsets.all(0)),
            ),
          ],
          onTap: (index) => setState(() {
            widget._currentIndex = index;
          }),
        ),
      );
    
  }
}
