import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainHomePage extends StatefulWidget   {
  @override
  State<StatefulWidget> createState() {
    return MainHomePageState();
  }
}

class MainHomePageState extends State<MainHomePage> with SingleTickerProviderStateMixin{
  List<String> topTabList = ["推荐", "动态", "Java", "Flutter"];



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            bottom: TabBar(
              controller: new TabController(length: topTabList.length, vsync: this),
              tabs: topTabList
                  .map((e) => Tab(
                        text: e,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
