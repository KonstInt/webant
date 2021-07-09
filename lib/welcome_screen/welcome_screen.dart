import 'package:flutter/material.dart';
import 'package:flutter_webant/welcome_screen/screens/sign_in.dart';
import 'package:flutter_webant/welcome_screen/screens/sign_up.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/launch_image.png"),
            Container(
              margin: EdgeInsets.only(top: 40, bottom: 40),
              child: Text(
                "Welcome!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black),
              ),
              
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20,),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  primary: Colors.orange,
                ),
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()))
                },
                child: Text("Create an account",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20,),
                child: FlatButton(
                  onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignIn()))
                  },
                  child: Text('I already have an account',
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                  textColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.black,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(5)),
                ))
          ],
        ),
      ),
    );
  }
}
