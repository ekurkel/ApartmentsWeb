import 'package:flutter/material.dart';

void showErrorSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String error) {
  scaffoldKey.currentState.showSnackBar(
    SnackBar(
      content: Text(error),
      backgroundColor: Colors.red,
    ),
  );
}

void showSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String text) {
  scaffoldKey.currentState.showSnackBar(
    SnackBar(content: Text(text)),
  );
}
