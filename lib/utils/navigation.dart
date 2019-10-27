import 'package:flutter/material.dart';

class Navigation {
  static Future<T> toScreen<T>({BuildContext context, Widget screen}) async {
    return await Navigator.push<T>(
      context,
      MaterialPageRoute(builder: (BuildContext context) => screen),
    );
  }

  static Future<T> toScreenRemoveUntil<T>({
    BuildContext context,
    dynamic screen,
  }) async {
    return await Navigator.pushAndRemoveUntil<T>(
      context,
      MaterialPageRoute(builder: (BuildContext context) => screen),
      (_) => false,
    );
  }

  static dynamic toScreenAndCleanBackStack({
    @required BuildContext context,
    @required Widget screen,
  }) async {
    return await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => screen),
      (_) => false,
    );
  }

  static bool pop<T>(BuildContext context, {T result}) {
    if (result == null) {
      return Navigator.of(context).pop();
    }
    return Navigator.of(context).pop<T>(result);
  }
}
