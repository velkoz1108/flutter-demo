import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeItemPage extends StatefulWidget {
  num pageIndex;
  String pageTitles;

  HomeItemPage(this.pageIndex, this.pageTitles);

  @override
  State<StatefulWidget> createState() {
    return HomeItemPageState();
  }
}

class HomeItemPageState extends State<HomeItemPage> {
  List<String> imageList = [
    "https://img1.baidu.com/it/u=3705250416,628008512&fm=26&fmt=auto",
    "https://img2.baidu.com/it/u=1930697310,3880237547&fm=26&fmt=auto",
    "https://img2.baidu.com/it/u=2348306338,241480762&fm=26&fmt=auto"
  ];

  int bannerIndex = 0;
  RefreshController refreshController = new RefreshController();

  @override
  Widget build(BuildContext context) {
    //创建列表
    return SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: true,
        onRefresh: onRefresh,
        onLoading: onLoading,
        child: buildListView());
  }

  Widget buildListView() {
    return ListView.builder(
          padding: EdgeInsets.only(top: 0),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0 && widget.pageIndex == 0) {
              return buildBannerFunction();
            }
            return Container(
              height: 130,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 2),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "这里是标题",
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("山高水长，执剑天涯，从你的点滴积累开始，所及之处，必精益求精，即使折腾每一天"),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "早起的年轻人",
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey[500]),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Icon(
                        Icons.thumb_up,
                        size: 18,
                        color: Colors.grey[500],
                      ),
                      Text(
                        "20",
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey[500]),
                      ),
                      SizedBox(
                        width: 26,
                      ),
                      Icon(
                        Icons.share,
                        size: 18,
                        color: Colors.grey[500],
                      ),
                      Text(
                        "120",
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey[500]),
                      ),
                    ],
                  )
                ],
              ),
            );
          });
  }

  Widget buildBannerFunction() {
    return Container(
        height: 200,
        child: Stack(children: [
          Positioned(
            child: Swiper(
                onIndexChanged: (value) {
                  setState(() {
                    bannerIndex = value;
                  });
                },
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Image.network(
                      imageList[index],
                      fit: BoxFit.cover,
                    ),
                  );
                }),
          ),
          Positioned(
            child: Container(
              padding: EdgeInsets.only(left: 4, right: 4),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Text(
                "${bannerIndex + 1}/3",
                style: TextStyle(fontSize: 15),
              ),
            ),
            bottom: 10,
            right: 10,
          )
        ]));
  }

  onRefresh() async {
    Future.delayed(Duration(milliseconds: 3000), () {
      refreshController.refreshCompleted();
    });
  }

  onLoading() async {
    Future.delayed(Duration(milliseconds: 3000), () {
      refreshController.loadComplete();
    });
  }
}
