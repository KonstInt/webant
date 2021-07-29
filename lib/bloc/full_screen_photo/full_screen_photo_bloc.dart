import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_webant/models/photo/photo.dart';
import 'package:flutter_webant/models/user/user_get.dart';
import 'package:flutter_webant/services/user/get_user.dart';
import 'package:meta/meta.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
part 'full_screen_photo_event.dart';
part 'full_screen_photo_state.dart';

class FullScreenPhotoBloc
    extends Bloc<FullScreenPhotoEvent, FullScreenPhotoState> {
  FullScreenPhotoBloc() : super(FullScreenPhotoInitial());

  @override
  Stream<FullScreenPhotoState> mapEventToState(
    FullScreenPhotoEvent event,
  ) async* {
    if (event is FullScreenPhotoLoadEvent) {
      yield FullScreenPhotoLoadingState();
      try {
        var user = await GetUser.getUser(event.photo.user);
        int seens = 0;
        

        var photoInfo = FirebaseFirestore.instance
            .collection('photos')
            .doc(event.photo.id.toString());
        await photoInfo
            .update(
              {
                'seens': FieldValue.increment(1),
              },
            )
            .then((value) => print("Sucsess"))
            .catchError((error) => photoInfo
                .set(
                  {
                    'seens': FieldValue.increment(1),
                  },
                )
                .then((value) => print("Sucsess"))
                .catchError((error) => print("Failed to add user: $error")));
          await photoInfo
            .get()
            .then<dynamic>((DocumentSnapshot snapshot) {
                seens = snapshot.get('seens');
            });
        if(user != null){
          var userInfo =
          FirebaseFirestore.instance.collection('users').doc(event.photo.user.substring(event.photo.user.lastIndexOf('/')+1));
          await userInfo
            .update({
              'seens': FieldValue.increment(1), 
              // John Doe
            })
            .then((value) => print("Sucsess"))
            .catchError((error) => userInfo
                .set({
                  'seens': FieldValue.increment(1), // John Doe
                })
                .then((value) => print("Sucsess"))
                .catchError((error) => print("Failed to add user: $error")));
         
            
        }
        yield FullScreenPhotoLoadedState(user, seens);
      } catch (e) {
        if (e == SocketException)
          yield FullScreenPhotoNoInternetState();
        else
          yield FullScreenPhotoErrorState();
      }
    }
  }
}
