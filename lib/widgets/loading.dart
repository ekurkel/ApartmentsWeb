import 'package:flutter/material.dart';

Widget loadingView() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircularProgressIndicator(value: 1),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('Загрузка...'),
      )
    ],
  ));
}
