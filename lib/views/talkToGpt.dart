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
// ignore: depend_on_referenced_packages

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

bool dialogVisable = false;

List<String> messageList = [];
List<Map> _messageList = [
  {
    "type": "GPT",
    "msg": "你好",
  },
  {
    "type": "USER",
    "msg": "你好",
  },
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

final ScrollController _scrollController = ScrollController();

class _CupertinoTextFieldExampleState extends State<messageWindow> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  double bottomSideH = 50.sp;

  void _hideBottomSide() {
    bottomSideH = 0;
  }

  void _showBottomSide() {
    bottomSideH = 50.sp;
  }

  void _sendMsgToGpt() async {
    if (_textController.text == '') {
      _showBottomSide();
      return;
    } else {
      setState(() {
        _messageList.insert(0, {"type": "USER", "msg": _textController.text});
        _textController = TextEditingController(text: '');
        dialogVisable = true;
      });
      _showBottomSide();
      String msgFromGpt = await talkToGpt(_textController.text);
      setState(() {
        _messageList.insert(0, {"type": "GPT", "msg": msgFromGpt});
        dialogVisable = false;
      });
      
    }
  }

  final _focusNode = FocusNode();

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
            item['msg']));
      }
    }
    return lists;
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
              Positioned(
                height: MediaQuery.of(context).size.height - 160.sp,
                width: MediaQuery.of(context).size.width,
                bottom: 60 + bottomSideH,
                child: ListView(
                  reverse: true,
                  padding: EdgeInsets.all(10.sp),
                  children: msgWidgetList(context, _messageList),
                ),
              ),
              Positioned(
                  bottom: 0,
                  height: 50.sp,
                  child: Container(
                    color: backColoor,
                    width: MediaQuery.of(context).size.width,
                    height: 52.sp,
                  )),
              Positioned(
                  bottom: bottomSideH,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                    color: backColoor,
                    width: MediaQuery.of(context).size.width,
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
                                  child: CupertinoButton.filled(
                                    alignment: Alignment.center,
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
              dialogVisable ? 
              Positioned(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                bottom: 0,
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Lottie.asset('assets/status/LoopEggs.json',
                          // alignment: Alignment(10,0),
                          width: 100.sp,
                          height: 200.sp,
                          repeat: true),
                    ),
                    color: Color.fromARGB(43, 80, 80, 80)),
              ):
              Container()
            ],
          ),
        ));
  }
}
