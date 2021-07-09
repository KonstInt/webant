import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomPasswordField extends StatefulWidget {
  String text;
  String RegExpStr;
  CustomPasswordField(this.text, this.RegExpStr);
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
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    widget.myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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

            if (!RegExp(widget.RegExpStr).hasMatch(value!)) {
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
              labelText: widget.text,
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
    );
  }

  
}
