import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webant/local_storage/hive_load.dart';
import 'package:flutter_webant/local_storage/hive_save.dart';
import 'package:flutter_webant/models/user/client/client_get.dart';
import 'package:flutter_webant/models/user/client/client_post.dart';
import 'package:flutter_webant/models/user/token/token_get.dart';
import 'package:flutter_webant/models/user/user_get.dart';
import 'package:flutter_webant/models/user/user_post.dart';
import 'package:flutter_webant/services/user/client_provider.dart';
import 'package:flutter_webant/services/user/token_provider.dart';
import 'package:flutter_webant/services/user/user_provider.dart';
import 'package:flutter_webant/services/user/user_provider_create.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoadingState());

  Future<String> getFirebase(user) async {
    try {
      var userInfo = FirebaseFirestore.instance
          .collection('users')
          .doc(user.id.toString());
      await userInfo.get().then<dynamic>((DocumentSnapshot snapshot) async {
        await HiveSave.saveAvatar(snapshot.get('avatar'));
      });
    } catch (_) {}
    return await HiveLoad.getAvatar();
  }

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    // TODO: implement mapEventToState
    String avatar = await HiveLoad.getAvatar();
    UserGet user = await HiveLoad.getUser();
    if (event is UserCreateEvent) {
      yield UserLoadingState();
      try {
        user = await UserProviderCreate.getUser(event.user, event.password);
        ClientGet client = await ClientProvider.getClient();
        await TokenProvider.getToken(
            client, user.username, event.password, 'password');
        HiveSave.saveUser(user.toJson());
        String avatar = await HiveLoad.getAvatar();
        yield UserLoadedState(user, avatar);
      } catch (_) {
        yield UserNotAccesState();
      }
    }

    if (event is UserLoadEvent) {
      yield UserLoadingState();
      try {
        String token = await HiveLoad.getToken();
        String username =
            await HiveLoad.getUser().then((value) => value.username);
        user = await UserProvider.getUser(username, token, 'password');
        HiveSave.saveUser(user.toJson());

        avatar = await getFirebase(user);
        yield UserLoadedState(user, avatar);
      } catch (e) {
        if (e == SocketException)
          yield UserNoInternetState(user, avatar);
        else
          yield UserNotAccesState();
      }
    }

    if (event is UserSignInEvent) {
      yield UserLoadingState();
      try {
        final UserGet user = await UserProvider.getUser(
            event.username, event.password, 'password');
        HiveSave.saveUser(user.toJson());

        avatar = await getFirebase(user);
        yield UserLoadedState(user, avatar);
      } catch (e) {
        if (e == SocketException)
          yield UserNoInternetState(user, avatar);
        else
          yield UserNotAccesState();
      }
    }
  }
}
