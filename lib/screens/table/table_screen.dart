import 'package:apartments/screens/table/bloc/table_bloc.dart';
import 'package:apartments/screens/table/bloc/table_state.dart';
import 'package:apartments/screens/table/widgets/table_item_widget.dart';
import 'package:apartments/utils/snack_bars.dart';
import 'package:apartments/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TableScreen extends StatefulWidget {
  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  TableBloc bloc;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    bloc = BlocProvider.of<TableBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TableBloc, TableState>(
      bloc: bloc,
      listener: (BuildContext context, TableState state) {
        if (state is TableFailure) {
          showErrorSnackBar(scaffoldKey, state.error);
        }
      },
      child: BlocBuilder<TableBloc, TableState>(
        bloc: bloc,
        builder: (BuildContext context, state) {
          return Scaffold(
            key: scaffoldKey,
            body: _getBody(state),
          );
        },
      ),
    );
  }

  Widget _getBody(TableState state) {
    print('TableState: ${state.toString()}');
    if (state.isLoading) {
      return loadingView();
    } else {
      if (state.table != null) {
        return ListView.builder(
          itemCount: state.table.items.length,
          itemBuilder: (BuildContext context, int index) {
            return TableItemWidget(content: state.table.items[index]);
          },
        );
      } else {
        return Center(
          child: Text('Данные не найдены'),
        );
      }
    }
  }
}
