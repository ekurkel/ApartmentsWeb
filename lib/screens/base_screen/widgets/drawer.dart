import 'package:apartments/navigation/navigation_bloc.dart';
import 'package:apartments/navigation/navigation_event.dart';
import 'package:apartments/navigation/navigation_screens.dart';
import 'package:apartments/navigation/navigation_state.dart';
import 'package:apartments/screens/table/bloc/table_bloc.dart';
import 'package:apartments/screens/table/bloc/table_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerToolbar extends StatelessWidget implements PreferredSizeWidget {
  final TableBloc tableBloc;
  DrawerToolbar(this.tableBloc);

  @override
  Widget build(BuildContext context) {
    NavigationBloc bloc = BlocProvider.of<NavigationBloc>(context);

    return Drawer(
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          bool isTablePicked = state.currentScreen == NavigationScreens.table;
          bool isChartsPicked = state.currentScreen == NavigationScreens.charts;
          return ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  toolbarButton(
                      context, 'Таблица', isTablePicked, Icons.table_chart, () {
                    bloc.add(ToScreen(NavigationScreens.table));
                  }),
                  toolbarButton(
                      context, 'Графики', isChartsPicked, Icons.insert_chart,
                      () {
                    bloc.add(ToScreen(NavigationScreens.charts));
                  }),
                  toolbarButton(context, 'Сохранить', false, Icons.arrow_back,
                      () {
                    tableBloc.add(SaveToCSV());
                  }),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget toolbarButton(BuildContext context, String title, bool isPicked,
      IconData icon, Function onClick) {
    return ListTile(
      onTap: () {
        onClick();
        Navigator.of(context).pop();
      },
      leading: Icon(icon, color: isPicked ? Colors.blue : Colors.black),
      title: Text(
        title,
        style: TextStyle(
            color: isPicked ? Colors.blue : Colors.black, fontSize: 16),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
