class UserBean {
  String name = "";
  int age = 0;
  String address = "";

  static UserBean fromJson(Map<String, dynamic> map) {
    Map<String, dynamic> dataMap = map["data"];
    UserBean userBean = new UserBean();
    userBean.name = dataMap["name"];
    userBean.age = dataMap["age"];
    userBean.address = dataMap["address"];
    return userBean;
  }
}
