import 'dart:async';

import 'package:apartments/navigation/navigation_event.dart';
import 'package:apartments/navigation/navigation_state.dart';
import 'package:bloc/bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  @override
  NavigationState get initialState => NavigationState();

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is ToScreen) {
      yield state.copyWith(currentScreen: event.screen);
    }
  }
}
