import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_webant/screens/new_photos.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
        child: MaterialApp(
            //color: Colors.white,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.pink),
            home: SafeArea(
              child: MyHomePage(),
            )));
  }
}

class MyHomePage extends StatefulWidget {
  //String titleInput;
  //String amountInput;
 
  final List<Widget> screens = [Photos('new'), Photos('popular')];
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  bool dialogshown = false;

static String myassetName = 'assets/images/news_feed.svg';
final Widget svgIcon = SvgPicture.asset(
  myassetName,
  color: Colors.grey[600]
  
);

final Widget svgIconActive = SvgPicture.asset(
  myassetName,
  color: Colors.pink
  
);
  //final tabs =
  @override
  Widget build(BuildContext context) {
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
              icon: svgIcon,
              activeIcon: svgIconActive,
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
  }
}
