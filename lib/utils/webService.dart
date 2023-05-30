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

//
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
Future<String> talkToGpt(String msg) async {
  Map<String,dynamic> messageFromUser = Map();
  messageFromUser['id']="1900829293939393rotk9008";
  messageFromUser['content']=msg;
  try {
    Response response = await Dio().post("https://ai.fhmuseum.cn/chatgpt/talk",data: messageFromUser);
    print(response);
    return response.data;
  } catch (e) {
    print(e);
      String errorMessage;
    if (e is DioError) {
      errorMessage = e.response.toString();
    } else {
      errorMessage = e.toString();
    }
    print(errorMessage);
    return errorMessage;
  }
}

