part of 'photo_bloc.dart';


abstract class PhotoEvent {}

class PhotoLoadEvent extends PhotoEvent{
  final String type;
  final int page;
  PhotoLoadEvent(this.type, this.page);


}



