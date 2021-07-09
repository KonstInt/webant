import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_webant/constants.dart';

import 'package:flutter_webant/welcome_screen/screens/welcome_screen.dart';
import 'package:overlay_support/overlay_support.dart';

import 'bottom_bar/photos/photos2_holder.dart';
import 'my_home_page.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            //color: Colors.white,
            debugShowCheckedModeBanner: false,
            
            theme: ThemeData(primarySwatch: Colors.pink, ),
            home: SafeArea(
              child: MyHomePage(),
            ));
  }
}

