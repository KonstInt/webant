part of 'photo_add_bloc.dart';

@immutable
abstract class PhotoAddState {}

class PhotoAddInitial extends PhotoAddState {}

class PhotoAddLoadingState extends PhotoAddState {}

class PhotoAddLoadedState extends PhotoAddState {
  Photo photo;
  PhotoAddLoadedState(this.photo);
}

class PhotoAddNotAccesState extends PhotoAddState {}

class PhotoAddNoInternetState extends PhotoAddState {}
