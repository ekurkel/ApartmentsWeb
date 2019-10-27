import 'package:equatable/equatable.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

abstract class TableEvent extends Equatable {}

class LoadInitialData extends TableEvent {
  final SpreadsheetTable table;

  LoadInitialData(this.table);

  @override
  List<Object> get props => [table];
}

class SaveToCSV extends TableEvent {
  @override
  List<Object> get props => [];
}
