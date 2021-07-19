import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_webant/bloc/photo_bloc/photo_bloc.dart';
import 'package:flutter_webant/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_webant/bottom_bar/photos/screens/photos2.dart';
import 'package:flutter_webant/main.dart';
import 'package:flutter_webant/root_page.dart';
import 'package:flutter_webant/widgets/custom_text_field.dart';
import 'package:flutter_webant/welcome_screen/screens/sign_up.dart';
import 'package:flutter_webant/welcome_screen/screens/welcome_screen.dart';
import 'package:flutter_webant/widgets/custom_password_field.dart';


import '../../constants.dart';
import '../../my_home_page.dart';

class SignIn extends StatefulWidget {
  static String myassetMailName = 'assets/images/mail_icon.svg';
  static String myassetEyeName = 'assets/images/eye_icon.svg';
  bool isObscure = true;
  CustomTextFiled email = CustomTextFiled(
      'Email*',
      Constants.mailIcon,
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      'Enter your real email address',
      0);

  CustomPasswordField password = CustomPasswordField(
      "Password*", r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Widget mailIcon = SvgPicture.asset(SignIn.myassetMailName,
      color: Colors.grey[600], height: 2, width: 2);

  final Widget eyeIcon = SvgPicture.asset(SignIn.myassetEyeName,
      color: Colors.grey[500], height: 20, width: 2);

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
            title: FlatButton(
              child: Text('Cancel',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w300)),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () => {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => WelcomeScreen(),
                  ),
                  (route) => false,
                )
              },
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
                    margin: EdgeInsets.only(
                      bottom: 35,
                      top: 90,
                    ),
                    child: Text(
                      "Sign In",
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
                  widget.email,
                  widget.password,
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        primary: Colors.orange,
                      ),
                      onPressed: () {
                        Constants.isInSystem = true;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => BlocProvider(
                      create: (context) => UserBloc()
                        ..add(new UserLoadEvent(widget.email.getText(), widget.password.getText())),
                      child:
                          //search
                          RootPage('')),
                          ),
                          
                        );
                      
                      },
                      child: Text("Sign In",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => SignUp(),
                            ),
                            (route) => false,
                          );
                        },
                        child: Text('Sign Up',
                            style:
                                TextStyle(color: Colors.black, fontSize: 15)),
                        textColor: Colors.black,
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
