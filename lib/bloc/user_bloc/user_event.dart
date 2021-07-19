part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserCreateEvent extends UserEvent {
    UserPost user;
    String password;
    UserCreateEvent(this.user, this.password);

}
class UserLoadEvent extends UserEvent {
    String username;
    String password;
    UserLoadEvent(this.username, this.password);

}
