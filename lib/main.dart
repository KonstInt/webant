import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webant/constants.dart';
import 'package:flutter_webant/local_storage/hive_load.dart';
import 'package:flutter_webant/root_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';


import 'bloc/photo_bloc/photo_bloc.dart';
import 'bloc/user_bloc/user_bloc.dart';
import 'my_home_page.dart';

void main() async {
  //`Constants.currentUser = HiveLoad.getUser();
  //Constants.token = HiveLoad.getToken();
  //Constants.refreshToken = HiveLoad.getRefreshToken();
  //Constants.isInSystem = HiveLoad.getInSystem();
  //Constants.password = HiveLoad.getPassword();
  await Hive.initFlutter();
  bool f = await HiveLoad.getInSystem();
  await Firebase.initializeApp();
  
    Constants.isInSystem = f;
    Constants.currentUser = await HiveLoad.getUser();
    Constants.refreshToken = await HiveLoad.getRefreshToken();
    Constants.token = await HiveLoad.getToken();
    Constants.password = await HiveLoad.getPassword();
    Constants.client = await HiveLoad.getClient();
    Constants.avatar = await HiveLoad.getAvatar();
  
  //PhotoBloc pb = PhotoBloc();
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

      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      
      home: BlocProvider(
          create: (context) => UserBloc()
            ..add(new UserLoadEvent(
                Constants.currentUser.email, Constants.password)),
          child:
              //search
              RootPage('auto')
      ),
    );
  }
}


