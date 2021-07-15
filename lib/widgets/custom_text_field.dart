import 'package:flutter/material.dart';

class CustomTextFiled extends StatefulWidget {
  String text;
  Widget icon;
  String RegExpStr;
  String ErrorMessage;
  int minLength;
  CustomTextFiled(this.text, this.icon, this.RegExpStr, this.ErrorMessage, this.minLength);

  @override
  _CustomTextFiledState createState() => _CustomTextFiledState();

  final myController = TextEditingController();
  bool isValid = true;
  String getText() {
    if (isValid)
      return myController.text;
    else
      return 'not valid';
  }
}

class _CustomTextFiledState extends State<CustomTextFiled> {
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
          controller: widget.myController,
          validator: (value) {
            if (value == '') {
              widget.isValid = true;
              return null;
            }

             if(value!.length < widget.minLength){
              widget.isValid = false;
              return 'Min ${widget.minLength} symbols!';
            }


            if (!RegExp(widget.RegExpStr).hasMatch(value)) {
              //widget.myController.text = 'error';
              widget.isValid = false;
              return widget.ErrorMessage;
            } else {
              widget.isValid = true;
              return null;
            }
          },
          //keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(

              //helperText: ' ',
              isDense: true,
              contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black54, width: 1.5),
              ),
              suffixIconConstraints:
                  BoxConstraints(minHeight: 44, minWidth: 30),
              border: OutlineInputBorder(),
              labelText: widget.text,
              suffixIcon: widget.icon),
        ),
      ),
    );
  }
}
