import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/main/main_discover_pages.dart';
import 'package:my_app/main/main_my_pages.dart';

import 'main/main_forum_pages.dart';
import 'main/main_home_pages.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<String> tabTitlesList = ["首页", "论坛", "发现", "我的"];

  List<String> normalIconUrl = [
    "home.png",
    "forum.png",
    "discover.png",
    "my.png"
  ];

  List<String> selectedIconUrl = [
    "home-active.png",
    "forum-active.png",
    "discover-active.png",
    "my-active.png"
  ];

  List<Widget> pageList = [
    MainHomePage(),
    MainForumPage(),
    MainDiscoverPage(),
    MainMyPage(),
  ];

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[selected],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "images/2.0/${normalIconUrl[0]}",
              width: 26,
              height: 26,
            ),
            activeIcon: Image.asset(
              "images/2.0/${selectedIconUrl[0]}",
              width: 26,
              height: 26,
            ),
            label: tabTitlesList[0],
            tooltip: "这是首页",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "images/2.0/${normalIconUrl[1]}",
              width: 26,
              height: 26,
            ),
            activeIcon: Image.asset(
              "images/2.0/${selectedIconUrl[1]}",
              width: 26,
              height: 26,
            ),
            label: tabTitlesList[1],
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "images/2.0/${normalIconUrl[2]}",
              width: 26,
              height: 26,
            ),
            activeIcon: Image.asset(
              "images/2.0/${selectedIconUrl[2]}",
              width: 26,
              height: 26,
            ),
            label: tabTitlesList[2],
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "images/2.0/${normalIconUrl[3]}",
              width: 26,
              height: 26,
            ),
            activeIcon: Image.asset(
              "images/2.0/${selectedIconUrl[3]}",
              width: 26,
              height: 26,
            ),
            label: tabTitlesList[3],
          )
        ],
        onTap: (value) {
          setState(() {
            selected = value;
          });
        },
        currentIndex: selected,
      ),
    );
  }
}
