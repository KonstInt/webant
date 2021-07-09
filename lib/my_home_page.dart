import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webant/constants.dart';
import 'package:flutter_webant/welcome_screen/screens/welcome_screen.dart';

import 'bottom_bar/photos/photos2_holder.dart';

class MyHomePage extends StatefulWidget {
  //String titleInput;
  //String amountInput;
 
  final List<Widget> screens = [//Photos('new'),
  WelcomeScreen(), PhotosHolder2()];
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  bool dialogshown = false;


  //final tabs =
  @override
  Widget build(BuildContext context) {

    if(Constants.isInSystem)
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: widget.screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Constants.svgIcon,
              activeIcon: Constants.svgIconActive,
              label: 'New'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_fire_department_outlined),
              label: 'Popular',
              backgroundColor: Colors.red),
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
