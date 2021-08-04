import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webant/local_storage/hive_load.dart';
import 'package:flutter_webant/root_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'bloc/user_bloc/user_bloc.dart';
import 'models/user/user_get.dart';

late UserGet currentUser;
late String token;
void main() async {
  await Hive.initFlutter();
  currentUser = await HiveLoad.getUser();
  await Firebase.initializeApp();
  token = await HiveLoad.getToken();

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
          create: (context) =>
              UserBloc()..add(new UserLoadEvent()),
          child:
              //search
              RootPage('auto')),
    );
  }
}
