import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webant/constants.dart';
import 'package:flutter_webant/welcome_screen/screens/welcome_screen.dart';

import 'bottom_bar/photos/photos2_holder.dart';
import 'bottom_bar/profile/screens/user_profile.dart';

class MyHomePage extends StatefulWidget {
  //String titleInput;
  //String amountInput;

  final List<Widget> screens = [
    //Photos('new'),
    PhotosHolder2(), WelcomeScreen(), UserProfile()
  ];
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  bool dialogshown = false;

  //final tabs =
  @override
  Widget build(BuildContext context) {
    if (Constants.isInSystem)
      return Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: widget.screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
         //` showSelectedLabels: false,
         // showUnselectedLabels: false,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Constants.svgHomeIcon,
              activeIcon: Constants.svgHomeIconActive,
              title: Padding(padding: EdgeInsets.all(0)),
            ),
            BottomNavigationBarItem(
                icon: Constants.svgFeedIcon,
                activeIcon: Constants.svgFeedIconActive,
                title: Padding(padding: EdgeInsets.all(0)),),
            BottomNavigationBarItem(
                icon: Constants.svgProfileIcon,
                activeIcon: Constants.svgProfileIconActive,
                title: Padding(padding: EdgeInsets.all(0)),
                ),
          ],
          onTap: (index) => setState(() {
            _currentIndex = index;
          }),
        ),
      );
    else
      return WelcomeScreen();
  }
}
