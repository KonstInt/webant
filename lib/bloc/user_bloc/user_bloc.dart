import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webant/local_storage/hive_save.dart';
import 'package:flutter_webant/models/client_post.dart';
import 'package:flutter_webant/models/user_get.dart';
import 'package:flutter_webant/models/user_post.dart';
import 'package:flutter_webant/services/user/user_provider.dart';
import 'package:flutter_webant/services/user/user_provider_create.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoadingState());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is UserCreateEvent) {
      yield UserLoadingState();
      try {
        final UserGet user =
            await UserProviderCreate.getUser(event.user, event.password);
        Constants.currentUser = user;
        yield UserLoadedState(user);
      } catch (_) {
        yield UserNotAccesState();
      }
    }
    if (event is UserLoadEvent) {
      yield UserLoadingState();
      try {

        

        final UserGet user = await UserProvider.getUser(
            event.username,
            event.password,
            new ClientPost(
                name: 'flutter',
                allowedGrantTypes: ["password", "refresh_token"]),
            'password');
        Constants.currentUser = user;
        try{
        var userInfo = FirebaseFirestore.instance
            .collection('users')
            .doc(Constants.currentUser.id.toString());
        await userInfo
            .get()
            .then<dynamic>((DocumentSnapshot snapshot) {
            Constants.avatar = snapshot.get('avatar');
            HiveSave.SaveAvatar(Constants.avatar);
        });
        }
        catch(_){

        }
        yield UserLoadedState(user);
      } catch (e) {
        if (e == SocketException)
          yield UserNoInternetState();
        else
          yield UserNotAccesState();
      }
    }
  }
}
