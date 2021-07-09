import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_webant/bottom_bar/photos/models/photo.dart';

import 'package:flutter_webant/bottom_bar/photos/photo_bloc/bloc/photo_bloc.dart';
import 'package:flutter_webant/constants.dart';


import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;

import 'full_screen_image.dart';

class Photos2 extends StatefulWidget {
  @override
  String type;
  Photos2(this.type);

  _PhotosState2 createState() => _PhotosState2();
}

class _PhotosState2 extends State<Photos2>  {

  
  List<Photo> _photos = [];
  //Current Page
  int currentPage = 1;
  //Flag For The End of List
  bool isLast = false;
  //Connection
  bool connection = false;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  //Refresh List of Photos
  void _onRefresh() async {
    _photos.clear();
    BlocProvider.of<PhotoBloc>(context).add(
                      PhotoLoadEvent(widget.type,1, true),
                    );
    _refreshController.refreshCompleted();
  }

  //Add Images to List  DFFDFGDGDFLDGFLDFGLDFLFDFGLDFGLGDFLGFLLDFGSLDFGLFGDL
  void _onLoading() async {
    currentPage++;
     BlocProvider.of<PhotoBloc>(context).add(
                      PhotoLoadEvent(widget.type,currentPage, false),
                    );
    //print(_photos.length );
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    String type = widget.type;
    type = type[0].toUpperCase() + type.substring(1);

    return Scaffold(
      body: Column(children: [
        AppBar(
          title: Text(type,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.purple[900])),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        Expanded(
          child: BlocListener<PhotoBloc, PhotoState>(
          listener: (context, state) {

            if(state is PhotoLoadedState){
              _photos.addAll(state.loadedPhoto);
            }
            // TODO: implement listener
          },
          child: BlocBuilder<PhotoBloc, PhotoState>(builder: (context, state) {
            return Container(
              //margin: EdgeInsets.only(top: 70),
              color: Colors.white,
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: ClassicHeader(),
                footer: CustomFooter(
                  builder: (BuildContext context, mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = CupertinoActivityIndicator();
                    } else if (mode == LoadStatus.loading) {
                      body = CupertinoActivityIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = Text("Load Failed!Click retry!");
                    } else if (mode == LoadStatus.canLoading) {
                      body = Text("release to load more");
                    } else {
                      body = Text("No more Data");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: (() {
                  if (state is PhotoErrorState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(Constants.noInternetPicturePath),
                          Text(
                            "No Data Connection Available.",
                          )
                        ],
                      ),
                    );
                  }
                  if (state is PhotoLoadingState) {
                    return Center(
                      child: Text('Loading...'),
                    );
                  }

                  if (state is PhotoLoadedState) {
                    return GridView.builder(
                      //padding: EdgeInsets.only(top: 15),

                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.all(5.0),
                              alignment: Alignment.center,
                              child: Container(
                                child: CachedNetworkImage(
                                  imageUrl: Constants.webAdressForPicture +
                                      _photos[index].image.name,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      CupertinoActivityIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            //GO to the full_screen_image
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FullScreenImage(
                                        _photos[index])));
                          },
                        );
                      },
                      itemCount: _photos.length,
                      //controller: _scrollViewController,
                    );
                  }
                }()),
              ),
            );
          }),
        )),
      ]),
    );
  }


  

}
