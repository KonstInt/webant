import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webant/bloc/photo_bloc/photo_bloc.dart';
import 'package:flutter_webant/bottom_bar/photos/screens/photos2.dart';
import 'package:flutter_webant/bottom_bar/profile/screens/user_settings.dart';
import 'package:flutter_webant/bottom_bar/profile/widgets/header_profile.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FlatButton(
          child: Text('Cancel',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w300)),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () => {},
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        // TODO: implement
        actions: [IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => UserSettings(),
            ),);}, icon: Icon(Icons.settings))],
        bottom: PreferredSize(
            child: Container(
              color: Colors.grey[600],
              height: 0.5,
            ),
            preferredSize: Size.fromHeight(0.5)),
        shadowColor: Colors.white,
      ),
      body: NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
                backgroundColor: Colors.white,
                collapsedHeight: 285,
                expandedHeight: 285,
                flexibleSpace: HeaderProfile())
          ];
        },
        body: BlocProvider(
          create: (context) => PhotoBloc()..add(PhotoLoadEvent('new', 1, true, '')),
          child: Photos2('new', 4, false, ''),
        ),
      ),
    );
  }
}
