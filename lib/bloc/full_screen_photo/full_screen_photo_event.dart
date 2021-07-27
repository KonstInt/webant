part of 'full_screen_photo_bloc.dart';

@immutable
abstract class FullScreenPhotoEvent {}

class FullScreenPhotoLoadEvent extends FullScreenPhotoEvent{
  Photo photo;

  FullScreenPhotoLoadEvent(this.photo);
}
