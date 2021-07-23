import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class PhotoAdd extends StatefulWidget {
  int steps = 1;
  @override
  _PhotoAddState createState() => _PhotoAddState();
}

class _PhotoAddState extends State<PhotoAdd> {
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

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
                    setState(() {_image = null;});
                    
                  },
                  child: Text('Cancel',
                      style: TextStyle(fontSize: 17, color: Colors.black)),
                ),
          leadingWidth: 100,
          actions: [
            TextButton(
                onPressed: () {
                  widget.steps == 1 ? widget.steps++ : null;
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
                    getImage();
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
