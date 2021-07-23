import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_webant/models/photo.dart';

import 'package:flutter_webant/services/photo/photos_provider.dart';




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
        
        final List<Photo>_loadedPhotosList = await PhotosProvider.getPhotos(event.type, event.page, event.name);
        if(_loadedPhotosList.isNotEmpty)
        yield PhotoLoadedState(_loadedPhotosList);
        else
        yield PhotoEmptyState();
      }
      catch (e) {
        if(e == SocketException)
         yield PhotoErrorState();
        else
          yield PhotoEmptyState(); 
      }
      
    

    }
  }
}
