import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'full_screen_photo_event.dart';
part 'full_screen_photo_state.dart';

class FullScreenPhotoBloc extends Bloc<FullScreenPhotoEvent, FullScreenPhotoState> {
  FullScreenPhotoBloc() : super(FullScreenPhotoInitial());

  @override
  Stream<FullScreenPhotoState> mapEventToState(
    FullScreenPhotoEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
