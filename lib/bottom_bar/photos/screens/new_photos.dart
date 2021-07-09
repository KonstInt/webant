import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_webant/bottom_bar/photos/models/photo.dart';
import 'package:flutter_webant/constants.dart';


import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;

import 'full_screen_image.dart';

class Photos extends StatefulWidget {
  @override
  String type;
  Photos(this.type);

  _PhotosState createState() => _PhotosState();
}

class _PhotosState extends State<Photos>  {
  //List of Data From server
  final List<Photo> photos = [];
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
    DefaultCacheManager manager = new DefaultCacheManager();
    manager.emptyCache();
    photos.clear();
    currentPage = 1;
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {});
    _refreshController.refreshCompleted();
  }

  //Add Images to List
  void _onLoading() async {
    if(connection)
    {currentPage++;
    var c = await getMoreData();
    if (c == -1) {
      _refreshController.loadFailed();
    } else if (isLast) {
      _refreshController.loadNoData();
    } else
      _refreshController.loadComplete();}
  }

  @override
  Widget build(BuildContext context) {
    String type = widget.type;
    type = type[0].toUpperCase() + type.substring(1);

    return Scaffold(
      body: Column(children: [
        AppBar(
          title: Text(type, style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.purple[900])),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),

        Expanded(
          child: FutureBuilder(
              future: fetchGallery(1),
              builder: (context, snapshot) {
                //No Internet Pic

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
                    onLoading: _onLoading ,
                    child: (() {
                      if (snapshot.data == -1){
                      connection = false;
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
                     } else if (snapshot.data == null) {
                       connection = false;
                        return Center(
                          child: Text('Loading...'),
                        );
                      } else
                        {
                          connection = true;
                          return GridView.builder(
                          //padding: EdgeInsets.only(top: 15),
                          
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                                          photos[index].image.name,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
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
                                        builder: (context) =>
                                            FullScreenImage(photos[index])));
                              },
                            );
                          },
                          itemCount: photos.length,
                          //controller: _scrollViewController,
                        );}
                    }()),
                  ),
                );
              }),
        ),

        //Header Of Page
        /*Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(21),
                    bottomRight: Radius.circular(21))),
            elevation: 5,
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            child: Container(
              width: double.infinity,
              height: 80,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                left: 20,
              ),
              padding: EdgeInsets.only(bottom: 10, top: 10),
              child: Text(type,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  )),
            ),
          ),*/
      ]),
    );
  }

  //Data Request
  Future<int> fetchGallery(int page) async {
    if (currentPage != page) return 0;
    var type = widget.type;
    final String adress = 'http://gallery.dev.webant.ru/api/photos?$type=true&page=$page&limit=20';
    try {
      final response = await http.get(
          Uri.parse(adress),
          headers: {'accept': 'application/json'});
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        var json = jsonDecode(response.body);
        print('OKKKKK');

        int i = 0;
        for (var x in json['data']) {
          Photo item = Photo.fromJson(x);
          photos.add(item);
          i++;
          //images.add(NetworkImage("http://gallery.dev.webant.ru/media/" +
          //                                      item.name));

        }
        if (i == 0) isLast = true;

        print(photos.length);
        print(currentPage);

        return 1;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.

        return -1;
      }
    } on SocketException catch (_) {
      print('EXXXX');
      return -1;
    }
  }

  //Data Request With Rebuild
  Future<int> getMoreData() {
    var codeResponse = fetchGallery(currentPage);
    if (codeResponse != null) {
      setState(() {});
    }
    return codeResponse;
  }

}
