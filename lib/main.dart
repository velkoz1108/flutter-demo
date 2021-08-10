import 'package:flutter/material.dart';
import 'index_page.dart';

void main() {
  runApp(RootApp());
}

class RootApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return RootAppState();
  }
}

class RootAppState extends State<RootApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IndexPage(),
    );
  }
}
