import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webant/bloc/photo_bloc/photo_bloc.dart';
import 'package:flutter_webant/bottom_bar/photos/screens/photos2.dart';

import 'screens/new_photos.dart';

class PhotosHolder2 extends StatefulWidget {
  final searchController = TextEditingController();

  @override
  _PhotosHolderState2 createState() => _PhotosHolderState2();
  bool isSearched = false;
}

class _PhotosHolderState2 extends State<PhotosHolder2> {
  //@override
  //bool get wantKeepAlive => true;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    widget.searchController.dispose();
    super.dispose();
  }

  @protected
  @override
  Widget build(BuildContext context) {
    //Photos2 search = new Photos2(' ', 2, false, widget.searchController.text);
    //super.build(context);
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        onScaleUpdate: (value) {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        onTapDown: (value) {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        
        child:  DefaultTabController(
        length: widget.isSearched ? 1 : 2,
        child: Scaffold(
          body: widget.isSearched
              ? NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                          backgroundColor: Colors.white,
                          title: CupertinoSearchTextField(
                            controller: widget.searchController,
                            padding: EdgeInsets.all(10),
                            onChanged: (value) {
                              if (value == '') {
                                widget.isSearched = false;
                                setState(() {});
                              }
                            },
                            onSubmitted: (value) {
                              if (value == '')
                                widget.isSearched = false;
                              else
                                widget.isSearched = true;

                              //PhotoBloc()..add(PhotoLoadEvent(
                              //'', 1, true, widget.searchController.text)   );
                              //TODO
                              //search.name = widget.searchController.text;
                              //search.setState(() {

                              //});
                              //TODO
                              //   search.Refresh();
                              setState(() {});
                            },
                          ),
                          floating: true,
                          pinned: true,
                          snap: true,
                          bottom: new TabBar(
                              //labelPadding: EdgeInsets.all(30),
                              indicatorPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              labelColor: Colors.black,
                              labelStyle: TextStyle(fontSize: 20),
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: Colors.pink,
                              tabs: <Tab>[
                                Tab(
                                  text: widget.searchController.text, //"Search",
                                ),
                              ])),
                    ];
                  },
                  body: BlocProvider(
                      create: (context) => PhotoBloc()
                        ..add(new PhotoLoadEvent(
                            '', 1, false, widget.searchController.text)),
                      child:
                          //search
                          Photos2(' ', 2, false, widget.searchController.text)),
                )
              : NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                          backgroundColor: Colors.white,
                          // foregroundColor: Colors.black,
                          title: CupertinoSearchTextField(
                            controller: widget.searchController,
                            padding: EdgeInsets.all(10),
                            onSubmitted: (value) {
                              if (value == '')
                                widget.isSearched = false;
                              else
                                widget.isSearched = true;

                              //PhotoBloc()..add(PhotoLoadEvent(
                              //'', 1, true, widget.searchController.text)   );
                              //TODO
                              //search.name = widget.searchController.text;
                              //search.setState(() {

                              //});
                              //TODO
                              //   search.Refresh();
                              setState(() {});
                            },
                          ),
                          floating: true,
                          pinned: true,
                          snap: true,
                          bottom: new TabBar(
                            //labelPadding: EdgeInsets.all(30),
                            indicatorPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            labelColor: Colors.black,
                            labelStyle: TextStyle(fontSize: 20),
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: Colors.pink,

                            tabs: <Tab>[
                              Tab(
                                text: "New",
                              ),
                              Tab(text: "Popular"),
                            ], // <-- total of 2 tabs
                          )),
                    ];
                  },
                  body: TabBarView(
                    children: <Widget>[
                      BlocProvider(
                        create: (context) =>
                            PhotoBloc()..add(PhotoLoadEvent('new', 1, true, '')),
                        child: Photos2('new', 2, false, ''),
                      ),
                      BlocProvider(
                        create: (context) => PhotoBloc()
                          ..add(PhotoLoadEvent('popular', 1, true, '')),
                        child: Photos2('popular', 2, false, ''),
                      ),
                    ],
                  )),
        ),
      ),
    );
  }
}
