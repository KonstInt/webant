part of 'full_screen_photo_bloc.dart';

@immutable
abstract class FullScreenPhotoState {}

class FullScreenPhotoInitial extends FullScreenPhotoState {}


class FullScreenPhotoLoadingState extends FullScreenPhotoState {}

class FullScreenPhotoLoadedState extends FullScreenPhotoState{
  UserGet user;
  FullScreenPhotoLoadedState(this.user);

}

class FullScreenPhotoNoInternetState extends FullScreenPhotoState{
  
}
class FullScreenPhotoNotAccesState extends FullScreenPhotoState{
  
}
