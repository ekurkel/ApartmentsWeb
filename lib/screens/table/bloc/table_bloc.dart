import 'dart:async';

import 'package:apartments/model/table.dart';
import 'package:apartments/screens/table/bloc/table_event.dart';
import 'package:apartments/screens/table/bloc/table_state.dart';
import 'package:apartments/services/file_services.dart';
import 'package:bloc/bloc.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  @override
  TableState get initialState => TableState();

  @override
  Stream<TableState> mapEventToState(TableEvent event) async* {
    if (event is LoadInitialData) {
      yield* _loadInitialData(event.table);
    } else if (event is SaveToCSV) {
      yield* _saveToFile();
    }
  }

  Stream<TableState> _loadInitialData(SpreadsheetTable table) async* {
    try {
      ApartmentTable apartmentTable = ApartmentTable.fromTable(table.rows);
      print('_loadInitialData: ${apartmentTable?.items?.length} categories');
      await Future.delayed(Duration(microseconds: 100));
      yield state.copyWith(table: apartmentTable, isLoading: false);
    } catch (error) {
      yield TableFailure(error: error);
    }
  }

  Stream<TableState> _saveToFile() async* {
    try {
      FileServices().saveFile(state.table);
    } catch (e, s) {
      print('$e, $s');
    }
  }
}
