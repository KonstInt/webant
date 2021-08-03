import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_webant/models/photo/photo.dart';
import 'package:flutter_webant/models/photo_add/media_object_add.dart';
import 'package:flutter_webant/models/photo_add/photo_post.dart';
import 'package:flutter_webant/services/photo_add/photo_add_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'photo_add_event.dart';
part 'photo_add_state.dart';

class PhotoAddBloc extends Bloc<PhotoAddEvent, PhotoAddState> {
  PhotoAddBloc() : super(PhotoAddInitial());

  @override
  Stream<PhotoAddState> mapEventToState(
    PhotoAddEvent event,
  ) async* {
    if(event is PhotoAddLoadEvent){
      yield PhotoAddLoadingState();
      try{
      Photo photo = await PhotoAddProvider.postPhoto(event.photo, event.image);
      yield PhotoAddLoadedState(photo);}
      catch(e){
         if (e == SocketException)
          yield PhotoAddNoInternetState();
        else
          yield PhotoAddNotAccesState();
      }
    }
    if(event is PhotoStateEvent){
      yield PhotoAddInitial();
    }
    // TODO: implement mapEventToState
  }
}
