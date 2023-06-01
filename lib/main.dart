import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:MovoLink/views/welcome.dart';
// import 'package:MovoLink/views/deviceInfo.dart';
// import 'package:MovoLink/views/deviceList.dart';
import 'package:letsgpt/views/autoTalks.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:fluro/fluro.dart';
import 'utils/application.dart';
import 'utils/routers.dart';



// import 'package:MovoLink/wave.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp, // 竖屏 Portrait 模式
      DeviceOrientation.portraitDown,
      // DeviceOrientation.landscapeLeft, // 横屏 Landscape 模式
      // DeviceOrientation.landscapeRight,
    ],
  );
  //这行代码用于隐藏状态栏
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
  // ScreenUtil.instance = ScreenUtil(width: 750, height: 1334);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    final router = new FluroRouter();
    Routes.configureRoutes(router);
    Application.routes = router;
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child){
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF75a137),
          fontFamily: 'Ubuntu',
          textTheme: TextTheme(
            labelLarge: TextStyle(fontSize: 18.sp),
          ),
        ),
        initialRoute: 'main', //配置默认访问路径 
        home: HomePage(),
        routes: const {
          //需要使用context指定上下文
          // '/wave': (context) => WithBuilder(), //
          // '/main': (context) => HomePage(), //
          // '/welcome': (context) => welcome(), //
          // '/deviceInfo': (context) => DeviceInfo(), //
          // '/deviceList': (context) => DeviceList(), //
          // '/autoTalks': (context) => talkToGpt(), //
        },
      );
      },
    );
  }
}

//配置路由规则
//final routes = {
//  '/': (context) => Main(),
//  '/StockManager': (context) => StockManager(),//入出库
////  '/page2': (context) => Page2(),
////  '/page3': (context) => Page3(),
//};

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListState();
  }
}

final userType = 'newUser';
void _toNext(BuildContext context, userFlag) {
  if (userFlag == 'newUser') {
    // Navigator.pushNamed(context, '/welcome');
    Application.routes
        .navigateTo(context, 'welcome', transition: TransitionType.fadeIn);
    // FluroRouter()
    //     .navigateTo(context, "welcome", transition: TransitionType.fadeIn);
  }
}

class ListState extends State<HomePage> {
  late Timer _timer;
  int count = 2;
  startTime() async {
    //设置启动图生效时间
    var _duration = new Duration(seconds: 1);
    new Timer(_duration, () {
      // 空等1秒之后再计时
      _timer = new Timer.periodic(const Duration(milliseconds: 400), (v) {
        count--;
        if (count == 0) {
          // Navigator.pushNamed(context, '/welcome');

          _toNext(context, userType);
        } else {
          setState(() {});
        }
      });
      return;
    });
  }

  @override
  void initState() {
    //页面初始化
    super.initState();
    startTime();
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // appBar: AppBar(title: Text('Movolink页面列表'),),
      // body: GridView.count(
      //     padding: EdgeInsets.all(5.0),
      //     //一行多少个
      //     crossAxisCount: 2,
      //     //滚动方向
      //     scrollDirection: Axis.vertical,
      //     // 左右间隔
      //     crossAxisSpacing: 5.0,
      //     // 上下间隔
      //     mainAxisSpacing: 5.0,
      //     //宽高比
      //     childAspectRatio: 2 / 2,
      //     //设置itemView
      //     children: initListWidget(context,MenuNun),
      // )
      body: Center(
          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: EdgeInsets.only(right: 9.5.sp)),
          Lottie.asset(
            'assets/status/loadeggs.json',
            // alignment: Alignment(10,0),
            width: 200.sp,
            height: 400.sp,
            // repeat: false
          ),
          // Lottie.asset(
          //   'assets/Mobilo/P.json',
          //   // alignment: Alignment(10,0),
          //   width: 100.sp,
          //   height: 200.sp,
          //   // repeat: false
          // ),
          // Lottie.asset(
          //   'assets/Mobilo/T.json',
          //   // alignment: Alignment(10,0),
          //   width: 100.sp,
          //   height: 200.sp,
          //   // repeat: false
          // ),
        ],
      )),
    );
  }
}




void _goToPage(BuildContext context, title) {
  if (title == '1') {
    Navigator.pushNamed(context, '/wave');
  } else if (title == 'Welcome') {
    Navigator.pushNamed(context, '/welcome');
  } else if (title == '设备检索') {
    Navigator.pushNamed(context, '/deviceSearch');
  } else if (title == '设备列表') {
    Navigator.pushNamed(context, '/deviceList');
  }
  print({new DateTime.now()});
  return;
}
