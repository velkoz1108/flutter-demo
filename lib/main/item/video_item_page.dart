import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/bean/VideoModel.dart';
import 'package:video_player/video_player.dart';

class VideoItemPage extends StatefulWidget {
  String tabValue;
  VideoModel videoModel;

  VideoItemPage(this.tabValue, this.videoModel);

  @override
  State<StatefulWidget> createState() {
    return VideoItemPageState();
  }
}

class VideoItemPageState extends State<VideoItemPage> {
  VideoPlayerController? videoPlayerController;

  //控制更新视频加载初始化完成状态
  Future? videoPlayFuture;

  @override
  void initState() {
    super.initState();

    print("uri is : ${widget.videoModel.videoUri}");
    videoPlayerController =
        VideoPlayerController.network(widget.videoModel.videoUri);

    videoPlayFuture = videoPlayerController!.initialize().then((_) {
      videoPlayerController!.play();
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildVideoWidget(),
        buildControllWidget(),
        buildBottomFlagWidget(),
        buildRightUserWidget(),
      ],
    );
  }

  buildVideoWidget() {
    return FutureBuilder(
        future: videoPlayFuture,
        builder: (BuildContext context, state) {
          if (state.connectionState == ConnectionState.done) {
            return InkWell(
                onTap: () {
                  if (videoPlayerController!.value.initialized) {
                    videoPlayerController!.value.isPlaying
                        ? videoPlayerController!.pause()
                        : videoPlayerController!.play();
                    setState(() {});
                  }
                },
                child: Center(
                  child: AspectRatio(
                    aspectRatio: videoPlayerController!.value.aspectRatio,
                    child: VideoPlayer(videoPlayerController),
                  ),
                ));
          } else {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          }
        });
  }

  buildControllWidget() {
    Widget itemWidget = Container();
    if (videoPlayerController!.value.initialized &&
        !videoPlayerController!.value.isPlaying) {
      itemWidget = InkWell(
        onTap: () {
          if (videoPlayerController!.value.initialized &&
              !videoPlayerController!.value.isPlaying) {
            videoPlayerController!.play();
            setState(() {});
          }
        },
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.all(Radius.circular(22))),
          child: Icon(
            Icons.play_arrow,
            size: 35,
          ),
        ),
      );
    }

    return Align(
      alignment: Alignment(0, 0),
      child: itemWidget,
    );
  }

  buildBottomFlagWidget() {
    return Positioned(
        left: 0,
        right: 64,
        bottom: 0,
        child: Container(
          height: 180,
          padding: EdgeInsets.only(left: 10, top: 10),
          color: Color(0x60ffffff),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "@早起的年轻人",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                "三十年河东，三十年河西，看看世界",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.white),
              )
            ],
          ),
        ));
  }

  buildRightUserWidget() {
    return Align(
        alignment: Alignment(1, 0.4),
        child: Container(
          width: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              //用户信息
              buildUserItem(),
              //关注
              buildFollowWidget(
                  widget.videoModel.isLike
                      ? "images/2.0/my.png"
                      : "images/2.0/my-active.png",
                  200, () {
                print("关注");
              }),
              //  评论
              buildFollowWidget("images/2.0/my.png", 200, () {
                showBottomFunction(1);
              }),
              //  转发
              buildFollowWidget("images/2.0/my.png", 300, () {
                showBottomFunction(2);
              })
            ],
          ),
        ));
  }

  buildUserItem() {
    return Container(
        width: 60,
        height: 60,
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, 0),
              child: ClipOval(
                child: Container(
                  color: Colors.grey,
                  width: 44,
                  height: 44,
                  child: Icon(Icons.map),
                ),
              ),
            ),
            widget.videoModel.isFollowed
                ? Container()
                : Align(
                    alignment: Alignment(0, 1),
                    child: Container(
                      width: 18,
                      child: Text(
                        "+",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
          ],
        ));
  }

  buildFollowWidget(String assetImage, int msgCount, callback) {
    return InkWell(
      onTap: callback,
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              assetImage,
              width: 44,
              height: 44,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "$msgCount",
              style: TextStyle(color: Colors.white, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  showBottomFunction(int i) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          if (i == 1) {
            return buildCommentWidget();
          } else {
            return buildShareWidget();
          }
        });
  }

  buildCommentWidget() {
    return Container(
      height: 500,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment(0, 0),
                child: Text(
                  "评论区",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              Align(
                  alignment: Alignment(1, 0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.clear,
                        size: 18,
                      ),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: Container(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return buildCommentItemWidget();
                    })),
          )
        ],
      ),
    );
  }

  buildCommentItemWidget() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Image.asset(
                "images/2.0/my.png",
                width: 30,
                height: 30,
              )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Eden",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    "天行健，君子以自强不息，地势坤，君子以厚德载物",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  margin: EdgeInsets.only(top: 6, right: 6),
                  padding: EdgeInsets.only(left: 6),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  child: Text(
                    "6小时前",
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  List<String> nameItems = ["微信", "朋友圈", "QQ", "QQ空间", "微博", "链接"];

  List<String> urlItems = [
    "images/2.0/my.png",
    "images/2.0/my.png",
    "images/2.0/my.png",
    "images/2.0/my.png",
    "images/2.0/my.png",
    "images/2.0/my.png"
  ];

  buildShareWidget() {
    return Container(
      height: 260,
      padding: EdgeInsets.only(top: 8),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: Container(
              height: 190,
              child: GridView.builder(
                  itemCount: nameItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 5.0,
                      childAspectRatio: 1.0),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 6, right: 6),
                          child: Image.asset(
                            urlItems[index],
                            width: 40,
                            height: 40,
                          ),
                        ),
                        Text(nameItems[index])
                      ],
                    );
                  }),
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 44,
              alignment: Alignment.center,
              child: Text("取消"),
            ),
          )
        ],
      ),
    );
  }
}
