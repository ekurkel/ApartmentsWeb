import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

import 'package:apartments/model/table.dart';
import 'package:firebase/firebase.dart' as firebase;

class FileServices {
  Future<html.File> showFilePicker() async {
    final completer = new Completer<html.File>();
    final html.InputElement input = html.document.createElement('input');
    input
      ..type = 'file'
      ..accept = '*';
    input.onChange.listen((e) async {
      final List<html.File> files = input.files;
      completer.complete(files[0]);
    });
    input.click();
    return completer.future;
  }

  Future<void> saveFile(ApartmentTable table) async {
    final firebase.App firebaseApp = firebase.app();
    try {
      firebase.StorageReference ref =
          firebaseApp.storage().ref('${DateTime.now().toIso8601String()}.csv');
      firebase.UploadTask task = ref.put(utf8.encode(table.toString()));
      await task.future;
      String downloadUrl = (await ref.getDownloadURL()).toString();
      print(downloadUrl);
      html.window.open(downloadUrl, 'document');
    } catch (e, s) {
      print('$e, $s');
    }
  }
}
