import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_webant/models/user/user_get.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial());

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if(event is SettingsLoadEvent){
      try{
        //UserGet currentUser  = await HiveLoad.getCurrent

      }
      catch(e){yield SettingsErrorState();}


    }
    // TODO: implement mapEventToState
  }
}
