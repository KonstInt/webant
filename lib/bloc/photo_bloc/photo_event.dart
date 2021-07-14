part of 'photo_bloc.dart';

@immutable
abstract class PhotoEvent {}

class PhotoLoadEvent extends PhotoEvent{
  final String type;
  final int page;
  final bool first;
  final String name;
  PhotoLoadEvent(this.type, this.page, this.first, this.name);


}





