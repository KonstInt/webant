import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class SignUp extends StatefulWidget {
  static String myassetMailName = 'assets/images/mail_icon.svg';
  static String myassetEyeName = 'assets/images/eye_icon.svg';
  static String myassetUsernameName = 'assets/images/username_icon.svg';
  static String myassetCalendarName = 'assets/images/calendar_icon.svg';
  bool isObscure = true;
  bool  isObscure2 = true;
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final Widget mailIcon = SvgPicture.asset(SignUp.myassetMailName,
      color: Colors.grey[600], height: 2, width: 2);

  final Widget eyeIcon = SvgPicture.asset(SignUp.myassetEyeName,
      color: Colors.grey[500], height: 20, width: 2);

  final Widget usernameIcon = SvgPicture.asset(SignUp.myassetUsernameName,
      color: Colors.grey[500], height: 2, width: 2);

  final Widget calendarIcon = SvgPicture.asset(SignUp.myassetCalendarName,
      color: Colors.grey[500], height: 2, width: 2);

  @override
  Widget build(BuildContext context) {
    final dateController = TextEditingController();
    

    @override
    void dispose() {
      // Clean up the controller when the widget is removed
      dateController.dispose();
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
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black, width: 2.0),
                            ),
                            suffixIconConstraints:
                                BoxConstraints(minHeight: 24, minWidth: 35),
                            border: OutlineInputBorder(),
                            labelText: 'Username*',
                            suffixIcon: usernameIcon),
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: TextField(
                          readOnly: true,
                          controller: dateController,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0),
                              ),
                              suffixIconConstraints:
                                  BoxConstraints(minHeight: 24, minWidth: 35),
                              border: OutlineInputBorder(),
                              labelText: 'Birthday',
                              suffixIcon: calendarIcon),
                          onTap: () async {
                            var date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));
                            dateController.text =
                                DateFormat('dd-MM-yyyy').format(date!);
                          },
                        )),
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black, width: 2.0),
                            ),
                            suffixIconConstraints:
                                BoxConstraints(minHeight: 44, minWidth: 30),
                            border: OutlineInputBorder(),
                            labelText: 'Email*',
                            suffixIcon: mailIcon),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        obscureText: widget.isObscure,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black, width: 2.0),
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'Password*',
                            suffixIcon: IconButton(
    
                                padding: EdgeInsets.only(left: 15),
                                onPressed: () {
                                  setState(() {
                                    widget.isObscure = !widget.isObscure;
                                    print(widget.isObscure);
                                  });
                                },
                                icon: eyeIcon)),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
    
                        obscureText: widget.isObscure2,
                    decoration: InputDecoration(
                        
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2.0),
                        ),
                        suffixIconConstraints:
                            BoxConstraints(minHeight: 44, minWidth: 30),
                        border: OutlineInputBorder(),
                        labelText: 'Confim Password*',
                        suffixIcon: IconButton(

                            padding: EdgeInsets.only(left: 15),
                            onPressed: () {
                              setState(() {
                                widget.isObscure2 = !widget.isObscure2;
                                print(widget.isObscure2);
                              });
                            },
                            icon: eyeIcon)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      primary: Colors.orange,
                    ),
                    onPressed: () => {},
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
