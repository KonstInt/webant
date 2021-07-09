import 'package:flutter/material.dart';

import '../../constants.dart';
import 'custom_password_field.dart';

class CustomPassWithConfim extends StatefulWidget {
 
  late CustomPasswordField password;
  CustomPassWithConfim(@required String text, @required String RegExpStr){
      password = CustomPasswordField(text, RegExpStr);

  }
  bool isObscure = true;
  bool isValid = true;
    final myController = TextEditingController();
    String getText() {
    if (isValid)
      return myController.text;
    else
      return 'not valid';
  }


 
  @override
  _CustomPassWithConfimState createState() =>
      _CustomPassWithConfimState();
}

class _CustomPassWithConfimState extends State<CustomPassWithConfim> {
  
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    widget.myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [




        widget.password,
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            autovalidate: true,
            child: TextFormField(
              validator: (value) {
                if (value == '') {
                  widget.isValid = true;
                  return null;
                }

                if(widget.password.getText() == null){
                  widget.isValid = false;
                  return 'Enter correct original password';
                }
                if (value != widget.password.getText()) {
                  //widget.myController.text = 'error';
                  widget.isValid = false;
                  return 'Password mismatch';
                } else {
                  widget.isValid = true;
                  return null;
                }
              },
              controller: widget.myController,
              obscureText: widget.isObscure,
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black54, width: 1.5),
                  ),
                  suffixIconConstraints:
                      BoxConstraints(minHeight: 44, minWidth: 30),
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password*',
                  suffixIcon: IconButton(
                      padding: EdgeInsets.only(left: 13),
                      onPressed: () {
                        setState(() {
                          widget.isObscure = !widget.isObscure;
                          print(widget.isObscure);
                        });
                      },
                      icon: Constants.eyeIcon)),
            ),
          ),
        ),
      ],
    );
  }

  
}
