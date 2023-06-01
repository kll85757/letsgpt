import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluro/fluro.dart';
import 'package:letsgpt/utils/application.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:lottie/lottie.dart';
import 'package:letsgpt/utils/setting.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
            '开始',
            style: TextStyle(color: mainBlue, fontSize: 18),
          ),
          // backgroundColor: Colors.white,
          onPressed: () {
            // Navigator.pushNamed(context, '/deviceSearch');
            Application.routes.navigateTo(context, 'talkToGpt',
                transition: TransitionType.fadeIn);
          },
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonLocation: CustomFloatingActionButtonLocation(
          FloatingActionButtonLocation.centerFloat, 0, 0),
      body: CupertinoPageScaffold(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.sizeOf(context).height,
          color: mainBlue,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.sizeOf(context).height,
            child: ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Container(
                        child: Text(
                          '随时GPT',
                          // maxLines: 4,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 70.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100.sp,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '最新智能自然语言模型',
                          speed: const Duration(milliseconds: 200),
                          textStyle: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                        TypewriterAnimatedText(
                          '随时随地为你解答一切',
                          speed: const Duration(milliseconds: 200),
                          textStyle: const TextStyle(
                            fontSize: 26.0,
                            color: Colors.white,
                          ),
                        ),
                        TypewriterAnimatedText(
                          '创作 营销 无所不能',
                          speed: const Duration(milliseconds: 200),
                          textStyle: const TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                        TypewriterAnimatedText(
                          '口袋里的生活导师',
                          speed: const Duration(milliseconds: 200),
                          textStyle: const TextStyle(
                            fontSize: 27.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                      totalRepeatCount: 99,
                    ),
                  ),
                  Positioned(
                    height: 160.sp,
                    width: MediaQuery.sizeOf(context).width,
                    bottom: 150.sp,
                    left: 50.sp,
                    child: Lottie.asset('assets/status/LoopEggs.json',
                        // alignment: Alignment(10,0),
                        width: 400.sp,
                        height: 400.sp,
                        repeat: true),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
