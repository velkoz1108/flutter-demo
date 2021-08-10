import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:my_app/base/BasePage.dart';
import 'package:my_app/home_page.dart';

class GuidePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GuidePageState();
  }
}

class GuidePageState extends BasePage<GuidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          if (index == 2) {
            return Stack(
              children: [
                Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Image.asset("images/2.0/guide01.jpeg",fit: BoxFit.fill,)
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 120,),
                        Text(
                          "书山有路勤为径",
                          style: TextStyle(color: Colors.black, fontSize: 22),
                        ),
                        SizedBox(height: 22,),
                        Text("学海无涯苦作舟",
                            style: TextStyle(color: Colors.black, fontSize: 22))
                      ],
                    )),
                Positioned(
                    bottom: 120,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                        child: Ink(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22)),
                              color: Colors.white),
                          child: InkWell(
                            onTap: () {
                              pushPage(HomePage());
                            },
                            borderRadius: BorderRadius.all(Radius.circular(22)),
                            splashColor: Colors.grey,
                            child: Container(
                              width: 90,
                              height: 28,
                              alignment: Alignment.center,
                              child: Text("进入首页"),
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            );
          } else {
            // return new Image.network("http://via.placeholder.com/350x150",
            //     fit: BoxFit.fill);
            return Image.asset("images/2.0/guide01.jpeg",fit: BoxFit.fill,);
          }
        },
        itemCount: 3,
        pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
