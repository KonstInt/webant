import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

