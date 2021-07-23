import 'package:flutter/material.dart';
import 'package:flutter_webant/local_storage/hive_save.dart';
import 'package:flutter_webant/widgets/custom_pass_with_confim.dart';
import 'package:flutter_webant/widgets/custom_password_field.dart';
import 'package:flutter_webant/widgets/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../constants.dart';

class UserSettings extends StatefulWidget {
  bool isObscure = true;
  bool isObscure2 = true;
  final dateController =
      TextEditingController(text: Constants.currentUser.birthday);

  CustomTextFiled username = CustomTextFiled(
      'Username*',
      Constants.usernameIcon,
      r"^[a-zA-Z0-9]([._-](?![._-])|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]$",
      "User name not defind",
      5,
      Constants.currentUser.username);
  CustomTextFiled email = CustomTextFiled(
      'Email*',
      Constants.mailIcon,
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      'Enter your real email address',
      0,
      Constants.currentUser.email);
  CustomPasswordField password = new CustomPasswordField(
      'Old Password', r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
  //CustomPasswordField password = CustomPasswordField("Password*", r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
  CustomPassWithConfim passwordConfim = CustomPassWithConfim(
      "New Password*", r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");

  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  XFile? _image;

  var userInfo = FirebaseFirestore.instance
      .collection('users')
      .doc(Constants.currentUser.id.toString());

  Future<void> addAvatar() {
    // Call the user's CollectionReference to add a new user
    return userInfo.set({
          'avatar': Constants.avatar, // John Doe
        })
        .then((value) => print("Sucsess"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    //var user = FirebaseFirestore.instance.collection('user').doc(Constants.currentUser.id.toString());
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
          .child(Constants.currentUser.id.toString())
          .child('avatar');
      var uploadTask = firebaseStorageRef.putFile(File(_image!.path));
      var taskSnapshot = await uploadTask.whenComplete(() {});
      Constants.avatar = await taskSnapshot.ref.getDownloadURL();
      HiveSave.SaveAvatar(Constants.avatar);

      setState(() {
        print("Profile Picture uploaded");
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }

    //widget.dateController.text = Constants.currentUser.birthday;
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
                              : Constants.avatar != ''
                                  ? Image.network(
                                      Constants.avatar,
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
                widget.username,
                Container(
                    width: double.infinity,
                    height: 43,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextField(
                      readOnly: true,
                      controller: widget.dateController,
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
                        widget.dateController.text =
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
                widget.email,
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text('Password',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500))),
                widget.password,
                widget.passwordConfim,
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
      ),
    );
  }
}
