import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'item/home_item_page.dart';

class MainHomePage extends StatefulWidget   {
  @override
  State<StatefulWidget> createState() {
    return MainHomePageState();
  }
}

class MainHomePageState extends State<MainHomePage> with SingleTickerProviderStateMixin{
  List<String> topTabList = ["推荐", "动态", "Java", "Flutter", "K8S", "Helm", "Chart", "Git"];

  TabController? tabController;

  List<Widget> bodyPageList = [];

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 8, vsync: this);

    for(int i =0; i < topTabList.length;i++){
      bodyPageList.add(new HomeItemPage(i,topTabList[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext buildContext,bool flag){
        return [SliverAppBar(
          pinned: true,
          floating: true,
          actions: [
            IconButton( icon: Icon(Icons.add_circle),onPressed: (){
              print("点击了添加");
            },)
          ],
          title: Ink(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(6))
            ),
            child: InkWell(
              onTap: (){
                print("点击了搜索框");
              },
              child: Container(
                height: 33,
                width: 400,
                child: Row(
                  children: [
                    SizedBox(width: 12,),
                    Icon(Icons.search,size: 18,),
                    SizedBox(width: 12,),
                    Text("搜索",style: TextStyle(fontSize: 14),)
                  ],
                ),
              ),
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            controller: tabController,
            tabs: topTabList
                .map((e) => Tab(
              text: e,
            ))
                .toList(),
          ),
        )];
        },
        body: TabBarView(
          controller: tabController,
          children: bodyPageList,
        ),
      ),
    );
  }
}
