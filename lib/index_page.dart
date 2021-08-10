import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base/BasePage.dart';
import 'guide_page.dart';
import 'home_page.dart';

class IndexPage extends StatefulWidget {
  @override
  State createState() {
    return IndexPageState();
  }
}

class IndexPageState extends BasePage<IndexPage> {
  bool myFirst = false;
  bool showWelcome = true;

  int totalSecond = 5;
  TimerUtil? timerUtil;
  num tick = 0;

  @override
  void initState() {
    super.initState();
    readCacheData();

    timerUtil = TimerUtil(mInterval: 200, mTotalTime: 5000);
    timerUtil!.setOnTimerTickCallback((millisUntilFinished) {
      setState(() {
        tick = millisUntilFinished / 1000;
        if (tick == 0) {
          // Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (BuildContext builder) => HomePage()));
          // RouterUtils.pushReplacePage(context, HomePage());
          pushReplacePage(HomePage());
        }
      });
    });
  }

  void readCacheData() async {
    final preferences = await SharedPreferences.getInstance();
    bool isFirst = preferences.getBool("isFirst");
    print("从本地缓存中取值 $isFirst");
    if (isFirst == null || !isFirst) {
      preferences.setBool("isFirst", true);
      pushPage(GuidePage());
    }else{
      timerUtil!.startCountDown();
    }

    showWelcome = true;
    myFirst = isFirst;

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBG(),
          buildTimerProgress(),
          buildLoading(),
          Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 100.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image(
                      image: AssetImage("images/2.0/logo.png"),
                      width: 28.0,
                      height: 28.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Text("Eden欢迎你！！！")
                ],
              ))
        ],
      ),
    );
  }

  buildBG() {
    if (showWelcome) {
      return Image(
        image: AssetImage("images/2.0/logo.png"),
        // width: 28.0,
        // height: 28.0,
        // fit: BoxFit.cover,
      );
    } else {
      return Container();
    }
  }

  buildTimerProgress() {
    return Positioned(
        right: 30,
        top: 30,
        child: InkWell(
          onTap: (){
            timerUtil!.cancel();
            pushPage(HomePage());
          },
            child: SizedBox(
                width: 30,
                height: 30,
                child: Stack(
                  children: [
                    CircularProgressIndicator(
                      value: (totalSecond - tick) / totalSecond + 0.01,
                    ),
                    Center(
                      child: Text("${tick.toInt()}s"),
                    )
                  ],
                ))));
  }

  buildLoading() {
    if (!showWelcome) {
      return Positioned(
          child: Center(
        child: SizedBox(
            width: 55.0, height: 55.0, child: CircularProgressIndicator()),
      ));
    } else {
      return Container();
    }
  }
}
