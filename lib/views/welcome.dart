import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluro/fluro.dart';
import 'package:letsgpt/utils/application.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:lottie/lottie.dart';
import 'package:letsgpt/utils/setting.dart';




//welcome

class welcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return welcomePage();
  }
}

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  FloatingActionButtonLocation location;
  double offsetX; // X方向的偏移量
  double offsetY; // Y方向的偏移量
  CustomFloatingActionButtonLocation(this.location, this.offsetX, this.offsetY);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    Offset offset = location.getOffset(scaffoldGeometry);
    return Offset(offset.dx + offsetX, offset.dy + offsetY);
  }
}

Widget titleSection = Container(
  padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
  color: Colors.transparent,
  child: Row(
    children: [
      Expanded(
        //分析1
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, //分析 2
          children: [
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(bottom: 3.0),
              child: Container(
                child: Text(
                  '欢迎使用',
                  maxLines: 4,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.sp,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                            color: luckyYellow,
                            offset: Offset(3, 3),
                            blurRadius: 0)
                      ]),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Container(
                child: Text(
                  '随时GPT',
                  maxLines: 4,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.sp,
                      color: Colors.white,
                      // shadows: [
                      //   Shadow(
                      //       color: Colors.black,
                      //       offset: Offset(7, 3),
                      //       blurRadius: 30)
                      // ]
                      ),
                ),
              ),
            ),
            Text(
              '最新智能自然语言模型',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  // shadows: [
                  //   Shadow(
                  //       color: Colors.black,
                  //       offset: Offset(3, 3),
                  //       blurRadius: 15)
                  // ]
                  ),
            ),
            Text(
              '随时随地为你解答一切',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  // shadows: [
                  //   Shadow(
                  //       color: Colors.black,
                  //       offset: Offset(10, 3),
                  //       blurRadius: 15)
                  // ]
                  ),
            ),
            // Text(
            //   '方寸不乱，掌控一切',
            //   style: TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.bold,
            //       fontSize: 15.sp,
            //       shadows: [
            //         Shadow(
            //             color: Colors.black,
            //             offset: Offset(10, 3),
            //             blurRadius: 15)
            //       ]),
            // ),
          ],
        ),
      ),
      Lottie.asset(
        'assets/Mobilo/Colon.json',
        // alignment: Alignment(10,0),
        width: 200.sp,
        height: 400.sp,
        repeat: false
      ),
    ],
  ),
);

class welcomePage extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //浮动按钮
      floatingActionButton: Container(
        height: 45,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        child: RawMaterialButton(
          child: Text(
            '开始使用',
            style: TextStyle(color: mainBlue, fontSize: 18),
          ),
          // backgroundColor: Colors.white,
          onPressed: () {
            // Navigator.pushNamed(context, '/deviceSearch');
            Application.routes.navigateTo(context, 'deviceSearch',transition: TransitionType.fadeIn);

          },
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonLocation: CustomFloatingActionButtonLocation(
          FloatingActionButtonLocation.centerFloat, 0, -40),
      body: new Container(
        decoration: BoxDecoration(
            image: new DecorationImage(
          alignment: Alignment(0.0, 1.0),
          image: new ExactAssetImage('assets/images/welcome_bg.png'),
          fit: BoxFit.cover,
        )),
        child: Container(
          color: mainBlue,
          child: titleSection,
        ),
      ),
    );
  }
}
