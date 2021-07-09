import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webant/bloc/photo_bloc/photo_bloc.dart';
import 'package:flutter_webant/bottom_bar/photos/screens/photos2.dart';


import 'screens/new_photos.dart';

class PhotosHolder2 extends StatefulWidget {
  @override
  _PhotosHolderState2 createState() => _PhotosHolderState2();
}

class _PhotosHolderState2 extends State<PhotosHolder2>
    with AutomaticKeepAliveClientMixin <PhotosHolder2> {
  @override
  Widget build(BuildContext context) {
    //super.build(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text("Application"),
                floating: true,
                pinned: true,
                snap: true,
                bottom: new TabBar(
                  tabs: <Tab>[
                    Tab(text: "New"),
                    Tab(text: "Popular"),
                  ], // <-- total of 2 tabs
                ),
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              BlocProvider(
                
                create: (context) => PhotoBloc()..add(PhotoLoadEvent('new',1, true)),
                child: Photos2('new'),
              ),
             BlocProvider(
                
                create: (context) => PhotoBloc()..add(PhotoLoadEvent('popular',1, true)),
                child: Photos2('ppular'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

