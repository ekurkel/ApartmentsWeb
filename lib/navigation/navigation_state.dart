import 'package:apartments/navigation/navigation_screens.dart';
import 'package:meta/meta.dart';

@immutable
class NavigationState {
  final NavigationScreens currentScreen;

  NavigationState({
    this.currentScreen = NavigationScreens.table,
  });

  NavigationState copyWith({NavigationScreens currentScreen}) {
    return NavigationState(
      currentScreen: currentScreen ?? this.currentScreen,
    );
  }
}

class NavigationFailure extends NavigationState {
  final String error;

  NavigationFailure({@required this.error}) : super();

  @override
  String toString() => 'NavigationFailure { error: $error }';
}
