import 'package:meta/meta.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

@immutable
class HomeState {
  final bool isLoading;

  HomeState({
    this.isLoading = false,
  });

  HomeState idle() => copyWith(isLoading: false);

  HomeState loading() => copyWith(isLoading: true);

  HomeState copyWith({List items, bool isLoading}) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class HomeFailure extends HomeState {
  final String error;

  HomeFailure({@required this.error}) : super();

  @override
  String toString() => 'HomeFailure { error: $error }';
}

class SuccessFileOpen extends HomeState {
  final Map<String, SpreadsheetTable> data;

  SuccessFileOpen(this.data);
}
