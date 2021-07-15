part of 'user_bloc.dart';

abstract class UserState{
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState{
  UserGet user;
  UserLoadedState(this.user);

}

class UserNoInternetState extends UserState{
  
}
class UserNotAccesState extends UserState{
  
}