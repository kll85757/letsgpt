import 'dart:async';

import 'dart:io';
import 'package:letsgpt/utils/setting.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';



List? AllDeviceData;
List? PickedData;

Map<String, double> fabSize = {'W': 100, 'H': 0};
double fabH = 100;
double fabW = 100;

@override
void initState() {
  //页面初始化
  // super.initState();
}

List MenuNun = [
  'Battery 01',
  'Battery 02',
  'Battery 03',
  'Battery 04',
];

class talkToGpt extends StatefulWidget {
  List? deviceName;
  List? data;
  talkToGpt({this.deviceName, this.data});

  @override
  State<StatefulWidget> createState() {
    MenuNun = deviceName!;
    print(MenuNun);
    AllDeviceData = data;
    // print(deviceName);
    // print(AllDeviceData);
    return ListPage();
  }
}

class ListPage extends State<talkToGpt> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: null,
          body: MenuWidget(),
        ));
  }
}

class MenuWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Menu();
  }
}

class Menu extends State<MenuWidget> {
  Widget titleSection() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 400,
                    height: 50,
                    child: Container(
                      // color: Colors.white,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(10, 0, 0, 0),
                            offset: new Offset(3, 3),
                            blurRadius: 20,
                          )
                        ],
                        // border: Border.all(
                        //   color: Colors.green, width: 2.0
                        // )
                      ),

                      ///距离顶部
                      margin: EdgeInsets.only(top: 0),
                      padding: EdgeInsets.all(0),

                      ///Alignment 用来对齐 Widget
                      alignment: Alignment(0, 0),
                      child: Text('112')
                    )),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: Row(children: [
                    Text(
                      'All Device',
                      maxLines: 4,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color(0xFF67A419),
                      ),
                    ),
                  ]),
                ),
                Text(
                  '匹配到的设备显示在这里',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  List<Widget> initListWidget(BuildContext context, List<String> MenuNun,
      // ignore: non_constant_identifier_names
      List<String> allDeType, List AllDeviceData, bool istapped) {
    List<Widget> lists = [];
    bool istapped = false;
    // print(AllDeviceData);
    if (AllDeviceData.isEmpty) {
      print('空的');
      // lists.add(Center(
      //   child: Text('空的'),
      // ));
    }

    for (var item in AllDeviceData) {
      var data = item;
      lists.add(
        StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AnimationConfiguration.staggeredList(
              position: 1,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Container(
                      // duration: Duration(milliseconds: 10),
                      // curve: Curves.fastOutSlowIn,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(10, 0, 0, 0),
                              offset: const Offset(4, 4),
                              blurRadius: 15,
                            ),
                          ],
                          border: null,
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                      // height: 50.0,
                      // width: 50.0,
                      child: new Center(
                        child:
                            Text('133'),
                      )),
                ),
              ),
            );
          },
        ),
      );
    }
    return lists;
  }

  bool _isTapped = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new Visibility(
          visible: true,
          maintainAnimation: false,
          // maintainSize: false,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: fabSize['H'],
            width: (MediaQuery.of(context).size.width - 20 * 2),
            // padding: ,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromARGB(226, 255, 255, 255),
            ),
          )),
      body: new Container(
        decoration: BoxDecoration(
            image: new DecorationImage(
                fit: BoxFit.cover,
                image: new ExactAssetImage('assets/images/listBg.png'))),
        child: Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height,
          // child: titleSection,
          child: Column(children: [
            Container(
              child: titleSection(),
            ),
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height - 200,
                      child: GridView.count(
                          padding: EdgeInsets.fromLTRB(20, 14, 20, 20),
                          //一行多少个
                          crossAxisCount: 2,
                          //滚动方向
                          scrollDirection: Axis.vertical,
                          // 左右间隔
                          crossAxisSpacing: 20.0,
                          // 上下间隔
                          mainAxisSpacing: 20.0,
                          //宽高比
                          childAspectRatio: 2 / 2,
                          children: [Text('11')]),
                    )
                  ],
                ))
          ]),
        ),
      ),
    );
  }
}
