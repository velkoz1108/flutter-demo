import 'package:flutter/material.dart';

class RouterUtils {
  static void pushPage(BuildContext context, Widget page) {
    if (page == null) {
      return;
    }
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext builder) => page));
  }

  static void pushReplacePage(BuildContext context, Widget page) {
    if (page == null) {
      return;
    }
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext builder) => page));
  }

  static void popPage(BuildContext context){
    Navigator.pop(context);
  }
}
