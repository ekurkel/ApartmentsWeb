import 'package:apartments/navigation/navigation_screens.dart';
import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {}

class ToScreen extends NavigationEvent {
  final NavigationScreens screen;

  ToScreen(this.screen);

  @override
  List<Object> get props => [screen];
}
