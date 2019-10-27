import 'package:apartments/navigation/navigation_bloc.dart';
import 'package:apartments/screens/home/home_screen.dart';
import 'package:firebase/firebase.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    try {
      firebase.initializeApp(
          apiKey: "AIzaSyBBzfCh-ZajWBcE1Wk8Z_WlocHZkOFfrLg",
          authDomain: "flutter-sport.firebaseapp.com",
          databaseURL: "https://flutter-sport.firebaseio.com",
          projectId: "flutter-sport",
          storageBucket: "flutter-sport.appspot.com",
          messagingSenderId: "310557447667");
    } catch (e, s) {
      print('firebase.initializeApp error: $e, $s');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<NavigationBloc>(builder: (context) => NavigationBloc()),
      ],
      child: MaterialApp(
        title: 'Apartments',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
