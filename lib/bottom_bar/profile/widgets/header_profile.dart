import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HeaderProfile extends StatefulWidget {
  _HeaderProfileState createState() => _HeaderProfileState();
}

class _HeaderProfileState extends State<HeaderProfile> {

   

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        
        Container(
          margin: EdgeInsets.all(25),
          child: CircleAvatar(
            radius: 65,
            backgroundImage: ExactAssetImage('assets/images/user_without_photo.png'),
            backgroundColor: Colors.transparent,
          )),
        Text('Username', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        SizedBox(height: 5),
        Text('1.01.1111', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15)),
        Spacer(), 
        Container(
          margin: EdgeInsets.only(left: 10,  top: 20),
          child: Row(
            
            children: [
            Text('Views: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Text('123', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15)),
            SizedBox(width: 10),
            Text('Loaded: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Text('12', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15)),
          ],),
        ),

        PreferredSize(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  color: Colors.grey[600],
                  height: 0.5,
                ),
                preferredSize: Size.fromHeight(0.5))
      ],


    );
  }
}