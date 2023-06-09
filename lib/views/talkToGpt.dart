import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluro/fluro.dart';
import 'package:letsgpt/utils/setting.dart';
import 'package:letsgpt/utils/model.dart';
import 'package:letsgpt/utils/webService.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:letsgpt/utils/application.dart';
// ignore: depend_on_referenced_packages

/// Flutter code sample for [CupertinoTabScaffold].

final width = window.physicalSize.width;
final height = window.physicalSize.height;

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

bool dialogVisable = false;

List<String> messageList = [];
List<Map> _messageList = [
  {
    "type": "GPT",
    "isHistoryMsg": false,
    "msg": "你好,可以为你做些什么？",
  },
  // {
  //   "type": "USER",
  //   "msg": "你好",
  // },
];

List<MsgModel>? messages;

Widget _renderItem(CountryModel itemData) {
  return GestureDetector(
    onTap: () {
      print("item clicked ${itemData.name}");
    },
    behavior: HitTestBehavior.opaque,
    child: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: ListTile(
            title: Text(itemData.name), trailing: Text(itemData.phoneCode))),
  );
}

// Widget _renderList() {
//   return ChatList(
//     msgCount: messages?.length ?? 0,
//     itemBuilder: (BuildContext context, int index) => _renderItem(index as CountryModel),
//     onMsgKey: (int index) => messages![index].id,
//     controller: chatListController,
//     // New message tip
//     showReceivedMsgButton: true,
//     onIsReceiveMessage: (int i) => messages![i].type == MsgType.receive,

//     // Scroll to top
//     showScrollToTopButton: true,

//   );
// }

class _CupertinoTextFieldExampleState extends State<messageWindow> {
  late TextEditingController _textController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: '');
    _scrollController.addListener(() {
      setState(() {
        _messageList[0]["isHistoryMsg"] = false;
      });
      // 到达了列表末尾，可以加载更多数据

      // if (_scrollController.position.pixels ==
      //     _scrollController.position.maxScrollExtent) {

      // }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  double bottomSideH = 50.sp;

  void _hideBottomSide() {
    bottomSideH = 0;
  }

  void resetListStatus() {
    for (var item in _messageList) {
      item['isHistoryMsg'] = false;
    }
  }

  void _showBottomSide() {
    bottomSideH = 50.sp;
  }

  void _sendMsgToGpt() async {
    var msgToGpt = _textController.text;
    resetListStatus();
    if (_textController.text == '') {
      _showBottomSide();
      return;
    } else {
      setState(() {
        _messageList.insert(
            0, {"type": "USER", "msg": msgToGpt, "isHistoryMsg": false});
        _textController = TextEditingController(text: '');
        dialogVisable = true;
      });
      _showBottomSide();
      String msgFromGpt = await talkToGpt(msgToGpt);

      setState(() {
        _messageList.insert(
            0, {"type": "GPT", "msg": msgFromGpt, "isHistoryMsg": true});
        dialogVisable = false;
      });
    }
  }

  final _focusNode = FocusNode();

  void _toSubPlan(){
    Application.routes
        .navigateTo(context, 'talkToGpt', transition: TransitionType.fadeIn);
  }

  void _onNewMessage() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  // ignore: non_constant_identifier_names
  List<Widget> msgWidgetList(BuildContext context, List MsgList) {
    List<Widget> lists = [];
    for (var item in MsgList) {
      if (item["type"] == "USER") {
        lists.add(getSenderView(ChatBubbleClipper1(type: BubbleType.sendBubble),
            context, item['msg']));
      } else {
        lists.add(getReceiverView(
            ChatBubbleClipper1(type: BubbleType.sendBubble),
            context,
            item['msg'],
            MsgList.indexOf(item),
            item["isHistoryMsg"]));
      }
    }
    return lists;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: true,
        navigationBar: CupertinoNavigationBar(
            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 15, 8),
            leading: Row(
              children: [
                Image(
                  alignment: Alignment.topCenter,
                  image: AssetImage('assets/images/AppIcon3.png'),
                  height: 60,
                  width: 60,
                ),
                Text(
                  '随时GPT',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            trailing: Container(
              width: 50.sp,
              padding:  EdgeInsets.all(3),
              child: CupertinoButton(
                borderRadius: const BorderRadius.all(
                  Radius.circular(25.0),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(2),
                color: CupertinoColors.activeGreen,
                child: const Text(
                  '订阅',
                  style: TextStyle(color: Colors.white,fontSize: 14),
                ),
                onPressed: () {
                  _sendMsgToGpt();
                },
              ),
            )
            // middle: Text('随时GPT'),
            ),
        child: Container(
            child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Stack(
            children: [
              Positioned(
                height: MediaQuery.sizeOf(context).height - 160.sp,
                width: MediaQuery.sizeOf(context).width,
                bottom: 60 + bottomSideH,
                child: ListView(
                  reverse: true,
                  controller: _scrollController,
                  padding: EdgeInsets.all(10.sp),
                  children: msgWidgetList(context, _messageList),
                ),
              ),
              Positioned(
                  bottom: 0,
                  height: 50.sp,
                  child: Container(
                    color: backColoor,
                    width: MediaQuery.sizeOf(context).width,
                    height: 52.sp,
                  )),

              Positioned(
                  bottom: bottomSideH,
                  child: Container(
                    // duration: Duration(seconds: 1),
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                    color: backColoor,
                    width: MediaQuery.sizeOf(context).width,
                    height: 52.sp,
                    child: Stack(
                      children: [
                        Positioned(
                          child: Wrap(
                            children: [
                              Container(
                                width: 242.sp,
                                height: 35.sp,
                                alignment: Alignment.center,
                                child: CupertinoTextField(
                                  textInputAction: TextInputAction.send,
                                  placeholder: '对ChatGPT提问',
                                  padding: EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                  ),
                                  controller: _textController,
                                  onChanged: (String value) async {},
                                  onSubmitted: (e) => {_sendMsgToGpt()},
                                  focusNode: _focusNode,
                                  onTap: _hideBottomSide,
                                  onTapOutside: (e) =>
                                      {_focusNode.unfocus(), _showBottomSide()},
                                ),
                              ),
                              const Padding(padding: EdgeInsets.only(left: 10)),
                              Container(
                                  width: 100,
                                  height: 35.sp,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(25.0),
                                      ),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 3.sp,
                                      )),
                                  child: CupertinoButton(
                                    alignment: Alignment.center,
                                    color: CupertinoColors.activeBlue,
                                    padding: EdgeInsets.all(1),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                    onPressed: () {
                                      _sendMsgToGpt();
                                    },
                                    child: const Text(
                                      '发送',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
              //是否显示加载动画
              dialogVisable
                  ? Positioned(
                      height: MediaQuery.sizeOf(context).height,
                      width: MediaQuery.sizeOf(context).width,
                      bottom: 0,
                      child: Container(
                          height: MediaQuery.sizeOf(context).height,
                          width: MediaQuery.sizeOf(context).width,
                          child: Center(
                            // child: Container(
                            //     decoration: BoxDecoration(
                            //       // border: Border.all(width: 1,color: Color(0x20111111)),
                            //       // boxShadow: [
                            //       //   BoxShadow(
                            //       //     color: Color.fromARGB(10, 0, 0, 0),
                            //       //     offset: new Offset(0, 0),
                            //       //     blurRadius: 5,
                            //       //   )
                            //       // ],
                            //       borderRadius: BorderRadius.all(
                            //         Radius.circular(5.0),
                            //       ),
                            //       color: Color(0xCFEBF1F6),
                            //     ),
                            //     width: 135.sp,
                            //     height: 135.sp,
                            //     padding: EdgeInsets.all(30.sp),
                            //     child:
                            //         Lottie.asset('assets/status/LoopEggs.json',
                            //             // alignment: Alignment(10,0),
                            //             width: 45.sp,
                            //             height: 45.sp,
                            //             repeat: true)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              //背景过滤器
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                                child: Opacity(
                                  opacity: 0.9,
                                  child: Container(
                                    width: 135.sp,
                                    height: 135.sp,
                                    padding: EdgeInsets.all(1.sp),
                                    decoration: BoxDecoration(
                                      color: Color(0xE3DEE1E4),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                    child: Center(
                                        child: Lottie.asset(
                                            'assets/status/loading_emo.json',
                                            // alignment: Alignment(10,0),
                                            width: 90.sp,
                                            height: 90.sp,
                                            repeat: true)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          color: Color(0x00C1CDE1)),
                    )
                  : Container()
            ],
          ),
        )));
  }
}
