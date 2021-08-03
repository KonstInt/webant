part of 'photo_add_bloc.dart';

@immutable
abstract class PhotoAddEvent {}

class PhotoAddLoadEvent extends PhotoAddEvent {
  PhotoPost photo;
  XFile? image;
  PhotoAddLoadEvent(this.photo,this.image);

}

class PhotoStateEvent extends PhotoAddEvent {
 
}
