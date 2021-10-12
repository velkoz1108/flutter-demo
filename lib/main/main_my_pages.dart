import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class MainMyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainMyPageState();
  }
}

class MainMyPageState extends State<MainMyPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildHeaderWidget(),
        buildBodyWidget(),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  buildHeaderWidget() {
    //获取状态栏高度
    double top = MediaQueryData.fromWindow(window).padding.top;
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.only(top: top),
              height: 30,
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              alignment: Alignment(-1, 0),
              child: Image.asset(
                "images/2.0/my.png",
                width: 30,
                height: 30,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.only(top: top),
              height: 30,
              color: Colors.white,
              padding: EdgeInsets.only(right: 16),
              alignment: Alignment(-1, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 44,
                    height: 26,
                    alignment: Alignment.center,
                    child: Text(
                      "签到",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Image.asset(
                    "images/2.0/my.png",
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Image.asset(
                    "images/2.0/my.png",
                    width: 30,
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildBodyWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 180,
                color: Colors.white,
              ),
              buildUserWidget()
            ],
          )
        ],
      ),
    );
  }

  buildCountBodyWidget(int count, String name) {
    return Expanded(
        child: Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$count",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "$name",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          )
        ],
      ),
    ));
  }

  buildUserWidget() {
    if (isLogin) {
      return buildUserLoginWidget();
    } else {
      return buildUserNoLoginWidget();
    }
  }

  buildUserLoginWidget() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 16, right: 16),
      height: 200,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                  right: 16,
                  left: 16,
                ),
                child: ClipOval(
                  child: Image.asset(
                    "images/2.0/logo.png",
                    width: 55,
                    height: 55,
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        "早起的年轻人",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        "images/2.0/my-active.png",
                        width: 20,
                        height: 20,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "阅读111天，总时长212小时",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        "images/2.0/my-active.png",
                        width: 15,
                        height: 15,
                      )
                    ],
                  )
                ],
              ))
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  child: Container(
                child: Row(
                  children: [
                    buildCountBodyWidget(21, "关注"),
                    buildCountBodyWidget(231, "粉丝"),
                    buildCountBodyWidget(121, "访问"),
                    buildCountBodyWidget(321, "排名"),
                  ],
                ),
              )),
              SizedBox(
                width: 20,
              ),
              Text(
                "主页",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              SizedBox(
                width: 14,
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16,
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
    );
  }

  buildUserNoLoginWidget() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      height: 200,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset(
                    "images/2.0/logo.png",
                    width: 55,
                    height: 55,
                  ),
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey)),
                ),
                Container(
                  child: Image.asset(
                    "images/2.0/logo.png",
                    width: 55,
                    height: 55,
                  ),
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey)),
                ),
                Container(
                  child: Image.asset(
                    "images/2.0/logo.png",
                    width: 55,
                    height: 55,
                  ),
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey)),
                ),
              ],
            ),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  print("点击了登录");
                  setState(() {
                    this.isLogin = true;
                  });
                },
                child: Container(
                  width: 120,
                  height: 46,
                  alignment: Alignment(0, 0),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    "登录/注册",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
