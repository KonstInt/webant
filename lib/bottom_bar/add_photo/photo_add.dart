import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webant/bloc/photo_add_bloc/photo_add_bloc.dart';
import 'package:flutter_webant/bottom_bar/add_photo/photo_add_builder.dart';
import 'package:flutter_webant/models/photo_add/photo_post.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class PhotoAdd extends StatefulWidget {
  int steps = 1;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  _PhotoAddState createState() => _PhotoAddState();
  
}

class _PhotoAddState extends State<PhotoAdd> {
  XFile? _image;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    widget.nameController.dispose();
    widget.descriptionController.dispose();
    super.dispose();
  }

 Future getImage(int i) async {
      XFile? image;
      if (i == 2)
        image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (i == 1)
        image = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;
        print('Image Path ${_image}');
      });
    }

  @override
  Widget build(BuildContext context) {
   

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
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          leading: widget.steps == 1
              ? null
              : TextButton(
                  onPressed: () {
                    widget.steps == 1 ? null : widget.steps--;

                    setState(() {
                      _image = null;
                    });
                  },
                  child: Text('Cancel',
                      style: TextStyle(fontSize: 17, color: Colors.black)),
                ),
          leadingWidth: 100,
          actions: [
            TextButton(
                onPressed: () {
                  //widget.steps == 1 ? widget.steps++ : null;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => BlocProvider(
                          create: (context) => PhotoAddBloc()
                            ..add(new PhotoAddLoadEvent(
                              new PhotoPost(
                                  name: widget.nameController.text,
                                  dateCreate: '',
                                  description:
                                      widget.descriptionController.text,
                                  isNew: true,
                                  isPopular: false,
                                  image: ''),
                              _image,
                            )),
                          child:
                              //search
                              PhotoAddBuilder()),
                    ),
                  );
                  setState(() {});
                },
                child: Text(widget.steps == 1 ? 'Next' : 'Add',
                    style: TextStyle(fontSize: 17)))
          ],
          backgroundColor: Colors.white,
          title: Text(
            'Load Photo',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(

              //mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup<void>(
                      context: context,
                      builder: (BuildContext context) => CupertinoActionSheet(
                        title: const Text(
                          'Add Photo',
                        ),
                        //message: const Text(''),
                        actions: <CupertinoActionSheetAction>[
                          CupertinoActionSheetAction(
                            child: const Text('Camera',
                                style: TextStyle(color: Colors.blue)),
                            onPressed: () {
                              getImage(1);
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: const Text('Gallery',
                                style: TextStyle(color: Colors.blue)),
                            onPressed: () {
                              getImage(2);
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    );
                  },
                  child: Container(
                      decoration: BoxDecoration(color: Colors.transparent),
                      margin: EdgeInsets.symmetric(vertical: 40),
                      width: double.infinity,
                      child: (_image != null)
                          ? Image.file(
                              File(_image!.path),
                              fit: BoxFit.fill,
                              width: double.infinity,
                            )
                          : Constants.svgAddPhotoIcon),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: widget.nameController,
                    decoration: InputDecoration(
                      //helperText: ' ',
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black54, width: 1.5),
                      ),

                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: widget.descriptionController,
                    textAlign: TextAlign.start,
                    minLines: 4,
                    maxLines: 4,
                    decoration: InputDecoration(
                        //helperText: ' ',
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.black54, width: 1.5),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                        alignLabelWithHint: true),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
