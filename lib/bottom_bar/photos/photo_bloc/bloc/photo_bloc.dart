import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_webant/bottom_bar/photos/models/photo.dart';
import 'package:flutter_webant/bottom_bar/photos/services/photos_provider.dart';



import 'package:meta/meta.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  
  PhotoBloc() : super(PhotoLoadingState());
  
  @override
  Stream<PhotoState> mapEventToState(
    PhotoEvent event,
  ) async* {
    
    if(event is PhotoLoadEvent){
      if(event.first)
        yield PhotoLoadingState();
      try{
        
        final List<Photo>_loadedPhotosList = await PhotosProvider.getPhotos(event.type, event.page);
        yield PhotoLoadedState(_loadedPhotosList);
      }
      catch(_){
        yield PhotoErrorState();
        
      }

    

    }
  }
}
