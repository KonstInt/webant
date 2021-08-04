part of 'photo_add_bloc.dart';

@immutable
abstract class PhotoAddState {}

class PhotoAddInitial extends PhotoAddState {}

class PhotoAddLoadingState extends PhotoAddState {}

class PhotoAddLoadedState extends PhotoAddState {
  UserGet user;
  String avatar;
  Photo photo;
  PhotoAddLoadedState(this.photo, this.avatar, this.user);
}

class PhotoAddNotAccesState extends PhotoAddState {}

class PhotoAddNoInternetState extends PhotoAddState {
  UserGet user;
  String avatar;
  PhotoAddNoInternetState(this.avatar, this.user);
}
