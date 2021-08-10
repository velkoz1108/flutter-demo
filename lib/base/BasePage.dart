import 'package:flutter/cupertino.dart';
import 'package:my_app/util/RouterUtils.dart';

abstract class BasePage<T extends StatefulWidget> extends State<T> {

  void pushPage(Widget page){
    RouterUtils.pushPage(context, page);
  }

  void pushReplacePage(Widget page){
    RouterUtils.pushReplacePage(context, page);
  }

  void popPage(){
    RouterUtils.popPage(context);
  }
}