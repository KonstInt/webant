import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_webant/welcome_screen/widgets/custom_pass_with_confim.dart';
import 'package:flutter_webant/welcome_screen/widgets/custom_password_field.dart';
import 'package:flutter_webant/welcome_screen/widgets/custom_text_field.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class SignUp extends StatefulWidget {
  bool isObscure = true;
  bool isObscure2 = true;
  final dateController = TextEditingController();
  CustomTextFiled username =  CustomTextFiled('Username*', Constants.usernameIcon, r"^[a-zA-Z0-9]([._-](?![._-])|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]$", "User name not defind");
  CustomTextFiled email = CustomTextFiled(
      'Email*',
      Constants.mailIcon,
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      'Enter your real email address');
      
  //CustomPasswordField password = CustomPasswordField("Password*", r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
  CustomPassWithConfim passwordConfim = CustomPassWithConfim("Password*", r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
  

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      // Clean up the controller when the widget is removed
      //widget.dateController.dispose();
      super.dispose();
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
          title: FlatButton(
            child: Text('Cancel',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w300)),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () => {Navigator.of(context).pop(true)},
          ),
          automaticallyImplyLeading: false,
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
                  margin: EdgeInsets.only(bottom: 35, top: 90),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      shadows: [
                        Shadow(color: Colors.black, offset: Offset(0, -5))
                      ],
                      color: Colors.transparent,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.pink,
                      fontSize: 30,
                    ),
                  ),
                ),
               
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
                            lastDate: DateTime(2100));
                        widget.dateController.text =
                            DateFormat('dd.MM.yyyy').format(date!);
                      },
                    )),
                widget.email,
                //widget.password,
                widget.passwordConfim,
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      primary: Colors.orange,
                    ),
                    onPressed: () {
                      print(widget.email.getText());
                    },
                    child:
                        Text("Sign Up", style: TextStyle(color: Colors.white)),
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: FlatButton(
                      onPressed: () => {},
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
