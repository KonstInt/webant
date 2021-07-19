import 'package:flutter/material.dart';
import 'package:flutter_webant/welcome_screen/screens/welcome_screen.dart';
import 'package:flutter_webant/widgets/custom_pass_with_confim.dart';
import 'package:flutter_webant/widgets/custom_password_field.dart';
import 'package:flutter_webant/widgets/custom_text_field.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

class UserSettings extends StatefulWidget {
  bool isObscure = true;
  bool isObscure2 = true;
  final dateController = TextEditingController();
  CustomTextFiled username = CustomTextFiled(
      'Username*',
      Constants.usernameIcon,
      r"^[a-zA-Z0-9]([._-](?![._-])|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]$",
      "User name not defind",
      5);
  CustomTextFiled email = CustomTextFiled(
      'Email*',
      Constants.mailIcon,
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      'Enter your real email address',
      0);
  CustomPasswordField password = new CustomPasswordField(
      'Old Password', r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
  //CustomPasswordField password = CustomPasswordField("Password*", r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
  CustomPassWithConfim passwordConfim = CustomPassWithConfim(
      "New Password*", r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");

  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
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
                    margin: EdgeInsets.only(top: 25, bottom:10),
                    child: CircleAvatar(
                      radius: 65,
                      backgroundImage: ExactAssetImage(
                          'assets/images/user_without_photo.png'),
                      backgroundColor: Colors.transparent,
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
                          suffixIcon: Constants.calendarIcon),
                      onTap: () async {
                        var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
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
                    onPressed: () {
                      //UserGet myUser;
                    },
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
