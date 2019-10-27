import 'package:apartments/screens/base_screen/base_screen.dart';
import 'package:apartments/screens/home/bloc/home_bloc.dart';
import 'package:apartments/screens/home/bloc/home_event.dart';
import 'package:apartments/screens/home/bloc/home_state.dart';
import 'package:apartments/utils/navigation.dart';
import 'package:apartments/utils/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc screenBloc = HomeBloc();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    screenBloc.add(LoadInitialData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: screenBloc,
      listener: (BuildContext context, HomeState state) {
        if (state is HomeFailure) {
          showErrorSnackBar(scaffoldKey, state.error);
        } else if (state is SuccessFileOpen) {
          if (state.data.keys.length > 1) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return addTabAlertDialog(context, state);
              },
            );
          } else {
            Navigation.toScreenAndCleanBackStack(
                context: context,
                screen: BaseScreen(table: state.data[state.data.keys.first]));
          }
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        bloc: screenBloc,
        builder: (BuildContext context, state) {
          return Scaffold(
            key: scaffoldKey,
            body: _getBody(state),
          );
        },
      ),
    );
  }

  Widget _getBody(HomeState state) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double aspectRatio = constraints.maxWidth / constraints.maxHeight;
        if (MediaQuery.of(context).size.width > 800) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(flex: 3, child: content(state)),
              Expanded(
                flex: aspectRatio < 1.4 ? 2 : 4,
                child: Image.asset(
                  'assets/login_picture.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        } else {
          return content(state);
        }
      },
    );
  }

  Widget content(HomeState state) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 20),
      child: Column(
        children: <Widget>[
          appName(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (state.isLoading)
                  Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(value: 1),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                            'Файл загружается. Это может занять 5-10 секунд...'),
                      )
                    ],
                  ))
                else
                  SizedBox(
                      width: MediaQuery.of(context).size.width < 500
                          ? MediaQuery.of(context).size.width
                          : 500,
                      child: RaisedButton(
                        onPressed: () {
                          screenBloc.add(OpenFile());
                        },
                        color: Colors.indigo,
                        child: Container(
                          width: 500,
                          alignment: Alignment.center,
                          child: Text('Открыть файл',
                              style: TextStyle(color: Colors.white)),
                        ),
                      )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget appName() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Apartments',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'Для начала работы загрузите файл с исходными данными.',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  AlertDialog addTabAlertDialog(BuildContext context, SuccessFileOpen state) {
    return AlertDialog(
      title: Text('Выберите таблицу:'),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: 300,
        child: ListView(
          children: state.data.keys
              .map((String name) => ListTile(
                    onTap: () async {
                      await Navigation.toScreenAndCleanBackStack(
                          context: context,
                          screen: BaseScreen(table: state.data[name]));
                    },
                    title: Text(name),
                  ))
              .toList(),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Отмена'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
