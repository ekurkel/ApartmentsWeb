import 'dart:html';

import 'package:apartments/screens/home/bloc/home_event.dart';
import 'package:apartments/screens/home/bloc/home_state.dart';
import 'package:apartments/services/file_services.dart';
import 'package:bloc/bloc.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FileServices fileServices = FileServices();
  @override
  HomeState get initialState => HomeState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadInitialData) {
      yield* _loadInitialData();
    } else if (event is OpenFile) {
      yield* _openFile();
    }
  }

  Stream<HomeState> _loadInitialData() async* {
    yield state.loading();

    try {
      yield state.idle();
    } catch (error) {
      yield HomeFailure(error: error);
    }
  }

  Stream<HomeState> _openFile() async* {
    try {
      final File fileData = await fileServices.showFilePicker();
      if (fileData != null) {
        yield state.loading();
        var reader = FileReader();
        reader.readAsArrayBuffer(fileData);
        await reader.onLoad.first;
        var decoder = SpreadsheetDecoder.decodeBytes(reader.result);
        Map<String, SpreadsheetTable> table = decoder.tables;
        yield SuccessFileOpen(table);
        yield state.idle();
      }
    } catch (e, s) {
      print('$e, $s');
      yield state.idle();
      yield HomeFailure(error: e);
    }
    yield state.idle();
  }
}
