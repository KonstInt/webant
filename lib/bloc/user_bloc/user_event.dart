part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserCreateEvent extends UserEvent {
    UserPost user;
    UserCreateEvent(this.user);

}
class UserLoadEvent extends UserEvent {
    String username;
    String password;
    UserLoadEvent(this.username, this.password);

}
