import 'package:apartments/model/table.dart';
import 'package:meta/meta.dart';

@immutable
class TableState {
  final bool isLoading;
  final ApartmentTable table;

  TableState({this.isLoading = false, this.table});

  TableState copyWith({bool isLoading, ApartmentTable table}) {
    return TableState(
      isLoading: isLoading ?? this.isLoading,
      table: table ?? this.table,
    );
  }

  @override
  String toString() => 'ApartmentTable: ${table?.items?.length} categories';
}

class TableFailure extends TableState {
  final String error;

  TableFailure({@required this.error}) : super();

  @override
  String toString() => 'TableFailure { error: $error }';
}
