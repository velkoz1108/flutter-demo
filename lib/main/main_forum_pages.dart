import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/bean/user_bean.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MainForumPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainForumPageState();
  }
}

class MainForumPageState extends State<MainForumPage> {
  String result = "";
  UserBean mUserBean = UserBean();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("网络请求"),
      ),
      body: Column(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("测试Get请求"),
                  IconButton(
                      onPressed: () {
                        getDataFromServer();
                      },
                      icon: Icon(Icons.query_stats_sharp)),
                ],
              ),
              Text("姓名是: ${mUserBean.name}"),
              Text("年龄是: ${mUserBean.age}"),
              Text("地址是: ${mUserBean.address}"),
              Text("是否有数据: ${mUserBean == null ? '无数据' : '有数据'}"),
            ],
          )),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("测试Post请求"),
                  IconButton(
                      onPressed: () {
                        saveDataToServer();
                      },
                      icon: Icon(Icons.post_add_rounded)),
                ],
              ),
              Text("提交的数据为formdata格式"),
            ],
          )),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("测试Post请求"),
                  IconButton(
                      onPressed: () {
                        saveDataToServer2();
                      },
                      icon: Icon(Icons.post_add_rounded)),
                ],
              ),
              Text("提交的数据为json格式"),
            ],
          )),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("上传文件"),
                  IconButton(
                      onPressed: () {
                        uploadFile();
                      },
                      icon: Icon(Icons.upload_file_outlined)),
                ],
              ),
            ],
          )),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("下载文件"),
                  IconButton(
                      onPressed: () {
                        downloadFile();
                      },
                      icon: Icon(Icons.download)),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }

  void getDataFromServer() async {
    Dio dio = new Dio();
    String url = "http://localhost:8888/user";
    Response response = await dio.get(url);

    Map<String, dynamic> dataMap = response.data;
    UserBean userBean = UserBean.fromJson(dataMap);

    setState(() {
      mUserBean = userBean;
      result = response.data.toString();
    });
  }

  // form data
  void saveDataToServer() async {
    print("save data to server");
    Dio dio = new Dio();
    String url = "http://localhost:8888/user";

    Map<String, dynamic> map = Map();
    map['name'] = 'qq';
    map['age'] = 26;
    map['address'] = 'sh';
    FormData formData = FormData.fromMap(map);

    Response response = await dio.post(url, data: formData);

    print(response.data.toString());
  }

  //json格式
  saveDataToServer2() async {
    print("save data to server 2");
    Dio dio = new Dio();
    String url = "http://localhost:8888/user";

    Map<String, dynamic> map = Map();
    map['name'] = 'qq';
    map['age'] = 26;
    map['address'] = 'sh';

    Response response = await dio.post(url, data: map);

    print(response.data.toString());
  }

  void uploadFile() async {
    String filePath = "";
    String url = "http://localhost:8888/user";
    Map<String, dynamic> map = Map();
    map["file"] =
        await MultipartFile.fromString(filePath, filename: "test.png");
    FormData formData = FormData.fromMap(map);

    Dio dio = new Dio();

    Response reponse = await dio.post(url, data: formData,
        onSendProgress: (int progress, int total) {
      print("进度：" + progress.toString() + "/" + total.toString());
    });

    print(reponse.data);
  }

  downloadFile() async {
    List<PermissionGroup> list = [];
    list.add(PermissionGroup.storage);
    await PermissionHandler().requestPermissions(list);

    Dio dio = new Dio();
    // String savePath = await getPhonePath();
    String appName = "test.png";

    dio.download("https://img0.baidu.com/it/u=1847694337,3290168101&fm=26&fmt=auto", "$appName",
        onReceiveProgress: (int count, int total) {
      print("进度：" + count.toString() + "/" + total.toString());
    });
  }

  Future<String> getPhonePath() async {
    final directory = Theme.of(context).platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
