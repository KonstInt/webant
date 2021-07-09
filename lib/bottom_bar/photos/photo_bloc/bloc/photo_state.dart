part of 'photo_bloc.dart';


abstract class PhotoState {}


class PhotoInitialState extends PhotoState {}
class PhotoEmptyState extends PhotoState {}

class PhotoFirstLoadedState extends PhotoState {
  List<Photo> loadedPhoto;
  PhotoFirstLoadedState(this.loadedPhoto);

  
}


class PhotoLoadedState extends PhotoState {
  List<Photo> loadedPhoto;
  PhotoLoadedState(this.loadedPhoto);

  
}

class PhotoLoadingState extends PhotoState {
 /*List<Photo> oldPhotos;
  bool isFirstFetch;
  PhotoLoadingState(this.oldPhotos,{this.isFirstFetch = false});*/
  

}


class PhotoErrorState extends PhotoState {}
