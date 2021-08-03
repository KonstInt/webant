import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webant/bloc/settings_bloc/settings_bloc.dart';
import 'package:flutter_webant/bloc/user_bloc/user_bloc.dart';
import 'package:flutter_webant/bottom_bar/profile/widgets/user_settings_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import 'package:flutter_webant/local_storage/hive_load.dart';
import 'package:flutter_webant/local_storage/hive_save.dart';
import 'package:flutter_webant/models/user/user_get.dart';
import 'package:flutter_webant/widgets/custom_pass_with_confim.dart';
import 'package:flutter_webant/widgets/custom_password_field.dart';
import 'package:flutter_webant/widgets/custom_text_field.dart';

import '../../../constants.dart';

class UserSettings extends StatefulWidget {
 

  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  
  late UserBloc blocOfSettings;
 
  @override
  void initState() {
    blocOfSettings = UserBloc();
    blocOfSettings..add(UserLoadEvent());
    
    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
    //var user = FirebaseFirestore.instance.collection('user').doc(Constants.currentUser.id.toString());
    
    //widget.dateController.text = Constants.currentUser.birthday;
    return BlocBuilder<UserBloc, UserState>(

      bloc: blocOfSettings,
      builder: (context, state) {

        if(state is UserNoInternetState)
        return UserSettingsWidget(currentUser: state.user, avatar: state.avatar);
        if(state is UserLoadedState)
        return UserSettingsWidget(currentUser: state.user, avatar: state.avatar);
        if(state is UserLoadingState)
        return Scaffold(body: Center(child: CupertinoActivityIndicator(),));
        else
        return Scaffold(body: Center(child: Text('Error'),));
      },
    
    );
  }
}
