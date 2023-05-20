import 'package:dio/dio.dart';
//api管理


//获取用户信息
Future getUserInfo() async {
  try {
    Response response = await Dio().get("http://www.google.com");
    print(response);
    return response.data;
  } catch (e) {
    print(e);
    return e;
  }
}

//把扫描出来的バーコード发给后端
Future sendBarcode() async {
  try {
    Response response = await Dio().get("http://www.google.com");
    print(response);

    return response.data;
  } catch (e) {
    print(e);
    return e;
  }
}

//向GPT3.5提问
Future talkToGpt() async {
  try {
    Response response = await Dio().get("http://www.google.com");
    print(response);
    return response.data;
  } catch (e) {
    print(e);
    return e;
  }
}

