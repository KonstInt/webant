import 'package:flutter/material.dart';

import 'screens/new_photos.dart';
class PhotosHolder extends StatefulWidget {
 
  @override
  _PhotosHolderState createState() => _PhotosHolderState();
}

class _PhotosHolderState extends State<PhotosHolder>  with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    //super.build(context);
    return DefaultTabController(
      length: 2,
      child:  Scaffold(
        body:  NestedScrollView(
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
              Photos('new'),
              Photos('popular'), 
             
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