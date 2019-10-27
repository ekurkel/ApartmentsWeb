import 'package:apartments/navigation/navigation_bloc.dart';
import 'package:apartments/navigation/navigation_screens.dart';
import 'package:apartments/navigation/navigation_state.dart';
import 'package:apartments/screens/base_screen/widgets/drawer.dart';
import 'package:apartments/screens/base_screen/widgets/toolbar.dart';
import 'package:apartments/screens/charts/charts_screen.dart';
import 'package:apartments/screens/table/bloc/table_bloc.dart';
import 'package:apartments/screens/table/bloc/table_event.dart';
import 'package:apartments/screens/table/table_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

class BaseScreen extends StatefulWidget {
  final SpreadsheetTable table;

  const BaseScreen({Key key, this.table}) : super(key: key);
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  TableBloc bloc;
  @override
  void initState() {
    bloc = TableBloc();
    bloc.add(LoadInitialData(widget.table));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<TableBloc>(builder: (context) => bloc)],
      child: Scaffold(
        appBar: MediaQuery.of(context).size.width > 800
            ? Toolbar(bloc)
            : AppBar(title: Text('Apartments')),
        drawer: MediaQuery.of(context).size.width > 800
            ? null
            : DrawerToolbar(bloc),
        body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            bool isTablePicked = state.currentScreen == NavigationScreens.table;
            bool isChartsPicked =
                state.currentScreen == NavigationScreens.charts;
            if (isTablePicked) {
              return TableScreen();
            } else if (isChartsPicked) {
              return ChartsScreen();
            } else {
              return Text('Error');
            }
          },
        ),
      ),
    );
  }
}
