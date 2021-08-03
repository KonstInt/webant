import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webant/bloc/settings_bloc/settings_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import 'package:flutter_webant/local_storage/hive_load.dart';
import 'package:flutter_webant/local_storage/hive_save.dart';
import 'package:flutter_webant/models/user/user_get.dart';
import 'package:flutter_webant/widgets/custom_pass_with_confim.dart';
import 'package:flutter_webant/widgets/custom_password_field.dart';
import 'package:flutter_webant/widgets/custom_text_field.dart';

import '../../../constants.dart';

class UserSettingsWidget extends StatefulWidget {
  UserGet currentUser;
  String avatar;
  UserSettingsWidget({
    required this.currentUser,
    required this.avatar,
  });
  @override
  _UserSettingsWidgetState createState() => _UserSettingsWidgetState();
}

class _UserSettingsWidgetState extends State<UserSettingsWidget> {
  XFile? _image;
  late SettingsBloc blocOfSettings;
  late final dateController;
  late CustomTextFiled username;
  late CustomTextFiled email;
  late CustomPasswordField password;
  late CustomPassWithConfim passwordConfim;
  var userInfo;
  @override
  void initState() {
    blocOfSettings = SettingsBloc();
    blocOfSettings..add(SettingsLoadEvent());
    dateController = TextEditingController(text: widget.currentUser.birthday);
    username = CustomTextFiled(
        'Username*',
        Constants.usernameIcon,
        r"^[a-zA-Z0-9]([._-](?![._-])|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]$",
        "User name not defind",
        5,
        widget.currentUser.username);
    email = CustomTextFiled(
        'Email*',
        Constants.mailIcon,
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        'Enter your real email address',
        0,
        widget.currentUser.email);

    password = new CustomPasswordField(
        'Old Password', r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
    //CustomPasswordField password = CustomPasswordField("Password*", r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
    passwordConfim = CustomPassWithConfim(
        "New Password*", r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");

    userInfo = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.currentUser.id.toString());
    super.initState();
  }

  Future<void> addAvatar() {
    // Call the user's CollectionReference to add a new user
    return userInfo
        .set({
          'avatar': widget.avatar, // John Doe
        })
        .then((value) => print("Sucsess"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async {
      //String fileName = basename(_image!.path);
      var firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child(widget.currentUser.id.toString())
          .child('avatar');
      var uploadTask = firebaseStorageRef.putFile(File(_image!.path));
      var taskSnapshot = await uploadTask.whenComplete(() {});
      widget.avatar = await taskSnapshot.ref.getDownloadURL();
      HiveSave.saveAvatar(widget.avatar);

      setState(() {
        print("Profile Picture uploaded");
        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          content: new Text("Data is update!"),
        ));
      });
    }

     return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
    
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text('Settings'),
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              actions: [
                Container(
                    margin: EdgeInsets.only(top: 5),
                    child: TextButton(
                        onPressed: () {
                          uploadPic(context);
                          addAvatar();
                        },
                        child: Text('Save')))
              ],
              bottom: PreferredSize(
                  child: Container(
                    color: Colors.grey[600],
                    height: 0.5,
                  ),
                  preferredSize: Size.fromHeight(0.5)),
              shadowColor: Colors.white,
            ),
            backgroundColor: Colors.white,
            body: SizedBox.expand(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 25, bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: CircleAvatar(
                            radius: 65,
                            child: ClipOval(
                                child: new SizedBox(
                              width: 180.0,
                              height: 180.0,
                              child: (_image != null)
                                  ? Image.file(
                                      File(_image!.path),
                                      fit: BoxFit.fill,
                                    )
                                  : widget.avatar != ''
                                      ? Image.network(
                                          widget.avatar,
                                          fit: BoxFit.fill,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                'assets/images/user_without_photo.png');
                                          },
                                        )
                                      : Image.asset(
                                          'assets/images/user_without_photo.png',
                                          fit: BoxFit.fill,
                                        ),
                              //),
                              //
                            )),
                            backgroundColor: Colors.transparent,
                          ),
                        )),
                    Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text('Load Photo',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w300))),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text('Personal Data',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500))),
                    username,
                    Container(
                        width: double.infinity,
                        height: 43,
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: TextField(
                          readOnly: true,
                          controller: dateController,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black54, width: 1.5),
                              ),
                              suffixIconConstraints:
                                  BoxConstraints(minHeight: 24, minWidth: 35),
                              border: OutlineInputBorder(),
                              labelText: 'Birthday',
                              //hintText: 'dddddddd',
    
                              suffixIcon: Constants.calendarIcon),
                          onTap: () async {
                            var date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            //Constants.currentUser.birthday =  DateFormat('dd.MM.yyyy').format(date!);
                            dateController.text =
                                DateFormat('dd.MM.yyyy').format(date!);
                          },
                        )),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text('E-mail address',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500))),
                    email,
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text('Password',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500))),
                    password,
                    passwordConfim,
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          primary: Colors.orange,
                        ),
                        onPressed: () {},
                        child:
                            Text("Sign Up", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: FlatButton(
                          onPressed: () {},
                          child: Text('Sign In',
                              style: TextStyle(color: Colors.black, fontSize: 15)),
                          textColor: Colors.black,
                        ))
                  ],
                ),
              ),
            ),
          ));
  }
}
