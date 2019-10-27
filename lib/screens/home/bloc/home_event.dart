import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class HomeEvent extends Equatable {}

class HomeButtonPressed extends HomeEvent {
  final String string;
  HomeButtonPressed({
    @required this.string,
  });

  @override
  String toString() => 'HomeButtonPressed { string: $string }';

  @override
  List<Object> get props => [string];
}

class LoadInitialData extends HomeEvent {
  @override
  List<Object> get props => null;
}

class OpenFile extends HomeEvent {
  @override
  List<Object> get props => null;
}
