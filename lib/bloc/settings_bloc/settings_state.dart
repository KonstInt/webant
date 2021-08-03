part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoadingState extends SettingsState {}

class SettingsLoadedState extends SettingsState {

    UserGet user;
    String avatar;
  SettingsLoadedState({
    required this.user,
    required this.avatar,
  });



}

class SettingsErrorState extends SettingsState {}
