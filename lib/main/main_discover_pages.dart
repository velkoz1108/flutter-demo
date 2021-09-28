import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/bean/VideoModel.dart';

import 'item/video_item_page.dart';

class MainDiscoverPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainDiscoverPageState();
  }
}

class MainDiscoverPageState extends State<MainDiscoverPage>
    with SingleTickerProviderStateMixin {
  List<String> tabTextList = ["关注", "推荐"];
  List<Tab> tabWidgetList = [];

  TabController? tabController;

  List<VideoModel> videoList = [];
  List<VideoModel> videoList2 = [];

  @override
  void initState() {
    super.initState();

    for (var value in tabTextList) {
      tabWidgetList.add(Tab(text: "$value"));
    }
    tabController = new TabController(length: tabTextList.length, vsync: this);

    for (int i = 0; i < 10; i++) {
      VideoModel videoModel = new VideoModel();

      videoModel.videoName = "视频$i";
      if(i%3 == 0){
        videoModel.videoUri = "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
      }else if (i%3 == 1){
        videoModel.videoUri = "https://media.w3.org/2010/05/sintel/trailer.mp4";
      }else{
        videoModel.videoUri = "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_30mb.mp4";
      }


      videoList.add(videoModel);
      videoList2.add(videoModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildRootBody();
  }

  Widget buildRootBody() {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: buildTableViewWidget()),
          Positioned(
            left: 0,
            right: 0,
            top: 54,
            child: buildTabBarWidget(),
          )
        ],
      ),
    );
  }

  Widget buildTableViewWidget() {
    return Container(
      color: Colors.black,
      child: TabBarView(
        controller: tabController,
        children: tabTextList
            .map((value) => buildTableViewItemWidget(value)).toList(),
      ),
    );
  }

  Widget buildTabBarWidget() {
    return Container(
      alignment: Alignment.topCenter,
      child: TabBar(
        controller: tabController,
        tabs: tabWidgetList,
        indicatorColor: Colors.white,
        indicatorWeight: 2.0,
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }

  //创建上下滑动的页面
  Widget buildTableViewItemWidget(String value) {
    List<VideoModel> list = [];
    if(value == '推荐'){
      list  = videoList;
    }else{
      list  = videoList2;
    }
    return PageView.builder(
      itemCount: list.length,
        //上下滑动
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext buildContext, int index) {
          return buildPageViewItemWidget(value, list[index]);
        });
  }

  buildPageViewItemWidget(String value, VideoModel videoModel) {
    return VideoItemPage(value,videoModel);
  }
}
