part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserCreateEvent extends UserEvent {
    UserPost user;
    String password;
    UserCreateEvent(this.user, this.password);

}
class UserSignInEvent extends UserEvent {
    String username;
    String password;
    UserSignInEvent(this.username, this.password);

}


class UserLoadEvent extends UserEvent {
  
}
class UserLoadSettingsEvent extends UserEvent {


}