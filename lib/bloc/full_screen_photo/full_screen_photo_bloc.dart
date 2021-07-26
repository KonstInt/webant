import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_webant/models/user_get.dart';
import 'package:flutter_webant/services/user/get_user.dart';
import 'package:meta/meta.dart';

part 'full_screen_photo_event.dart';
part 'full_screen_photo_state.dart';

class FullScreenPhotoBloc extends Bloc<FullScreenPhotoEvent, FullScreenPhotoState> {
  FullScreenPhotoBloc() : super(FullScreenPhotoInitial());

  @override
  Stream<FullScreenPhotoState> mapEventToState(
    FullScreenPhotoEvent event,
  ) async* {
    if(event is FullScreenPhotoLoadEvent){
      yield FullScreenPhotoLoadingState();
      try{
        var user = await GetUser.getUser(event.path);
        yield FullScreenPhotoLoadedState(user);

      }
      catch(e){
        if (e == SocketException)
          yield FullScreenPhotoNoInternetState();
        else
          yield FullScreenPhotoErrorState();
      }
    }
    // TODO: implement mapEventToState
  }
}
