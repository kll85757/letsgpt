import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
// import 'package:MovoLink/views/StockManager.dart';
import 'package:letsgpt/views/welcome.dart';
import 'package:letsgpt/views/talkToGpt.dart';
// import 'package:MovoLink/views/deviceList.dart';
// import 'package:MovoLink/views/deviceSearch.dart';

//欢迎页面
var welcomeHandler = Handler(
  // ignore: non_constant_identifier_names
  handlerFunc: (BuildContext, Map<String, List<String>> params) {
    return welcome();
  },
);

// GPT对话页
var talkToGptHandler = Handler(
  handlerFunc: (BuildContext, Map<String, List<String>> params) {
    return messageWindow();
  },
);

//sqflite数据库
var sqfliteHandler = Handler(
  handlerFunc: (BuildContext, Map<String, List<String>> params) {
    //return SqflitePage();
    // return SharePage();
  },
);

// 列表页
var listHandler = Handler(
  handlerFunc: (BuildContext, Map<String, List<String>> params) {
    // return DeviceList();
  },
);

// 设备详情
var infoHandler = Handler(
  handlerFunc: (BuildContext, Map<String, List<String>> params) {
    //return FileZipDemo();
    // return DeviceInfo();
  },
);
