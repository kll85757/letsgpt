import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluro/fluro.dart';
import 'package:letsgpt/utils/setting.dart';

/// Flutter code sample for [CupertinoTabScaffold].

class messageWindow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CupertinoTextFieldExampleState();
  }
}

// class mainWindow extends State<messageWindow>{
//   @override
//   Widget build(BuildContext context) {
//     return _CupertinoTextFieldExampleState();
//   }
// }

List<String> messageList = ['你好', '你好'];

class _CupertinoTextFieldExampleState extends State<messageWindow> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: '对ChatGPT提问');
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('接口测试'),
        ),
        // child: Center(
        //   child: CupertinoTextField(
        //     controller: _textController,
        //   ),
        // ),
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Stack(
            children: [
              const Positioned(
                  top: 100,
                  child: Text(
                    '1',
                    strutStyle: StrutStyle(fontSize: 10),
                  )),
              Positioned(top: 200, child: Text('2')),
              Positioned(
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                    color: backColoor,
                    width: MediaQuery.of(context).size.width,
                    height: 60.sp,
                    child: Stack(
                      children: [
                        Positioned(
                          child: Wrap(
                            children: [
                              Container(
                                width: 242.sp,
                                height: 30,
                                child: CupertinoTextField(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                  ),
                                  controller: _textController,
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(left: 10)),
                              Container(
                                  width: 100,
                                  height: 30,
                                  child: CupertinoButton.filled(
                                    
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                    onPressed: () {},
                                    child: const Text('发送'),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
