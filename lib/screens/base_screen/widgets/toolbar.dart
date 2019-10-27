import 'package:apartments/navigation/navigation_bloc.dart';
import 'package:apartments/navigation/navigation_event.dart';
import 'package:apartments/navigation/navigation_screens.dart';
import 'package:apartments/navigation/navigation_state.dart';
import 'package:apartments/screens/table/bloc/table_bloc.dart';
import 'package:apartments/screens/table/bloc/table_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Toolbar extends StatelessWidget implements PreferredSizeWidget {
  final TableBloc tableBloc;
  Toolbar(this.tableBloc);

  @override
  Widget build(BuildContext context) {
    NavigationBloc bloc = BlocProvider.of<NavigationBloc>(context);

    return AppBar(
      title: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          bool isTablePicked = state.currentScreen == NavigationScreens.table;
          bool isChartsPicked = state.currentScreen == NavigationScreens.charts;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Apartments',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Row(
                children: <Widget>[
                  toolbarButton(context, 'Таблица', isTablePicked, () {
                    bloc.add(ToScreen(NavigationScreens.table));
                  }),
                  toolbarButton(context, 'Графики', isChartsPicked, () {
                    bloc.add(ToScreen(NavigationScreens.charts));
                  }),
                ],
              ),
              toolbarButton(context, 'Сохранить', false, () {
                tableBloc.add(SaveToCSV());
              }),
            ],
          );
        },
      ),
    );
  }

  Widget toolbarButton(
      BuildContext context, String title, bool isPicked, Function onClick) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FlatButton(
            padding: EdgeInsets.zero,
            onPressed: onClick,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
            ),
            shape: isPicked
                ? Border(
                    bottom: BorderSide(
                        color: Theme.of(context).accentColor, width: 3))
                : null,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
