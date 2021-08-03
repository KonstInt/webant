part of 'user_bloc.dart';

abstract class UserState{
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState{
  UserGet user;
  String avatar;
  UserLoadedState(this.user, this.avatar);

}

class UserNoInternetState extends UserState{
  UserGet user;
  String avatar;
  UserNoInternetState(this.user, this.avatar);
  
}
class UserNotAccesState extends UserState{
  
}