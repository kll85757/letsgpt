import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:letsgpt/utils/setting.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class MsgModel {
  MsgModel(
      {required this.id,
      required this.msg,
      required this.type,
      required this.time});
  String id;
  String msg;
  MsgType type;
  DateTime time;
}

enum MsgType {
  sent,
  receive,
  timetag,
}

class CountryModel {
  CountryModel(
      {required this.name, required this.countryCode, required this.phoneCode});
  String name;
  String countryCode;
  String phoneCode;
}

typedef SectionViewOnFetchAlphabet<T> = String Function(T header);

class AlphabetHeader<T> {
  AlphabetHeader({required this.alphabet, required this.items});
  String alphabet;
  List<T> items;
}

getTitleText(String title) => Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    );

getSenderView(CustomClipper clipper, BuildContext context, String msg) =>
    ChatBubble(
      clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(top: 20),
      shadowColor: Colors.transparent,
      backGroundColor: mainBlue,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Text(
          msg,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal),
        ),
      ),
    );

getReceiverView(CustomClipper clipper, BuildContext context, String msg,
        int index, bool isHistoryMsg) =>
    ChatBubble(
      clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
      backGroundColor: Color.fromARGB(255, 255, 255, 255),
      shadowColor: Colors.transparent,
      margin: EdgeInsets.only(top: 20),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Column(children: [
          isHistoryMsg
              ? Container(
                  key: ValueKey(index),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        msg,
                        speed: const Duration(milliseconds: 25),
                        textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                    totalRepeatCount: 1,
                  ))
              : Container(
                  key: ValueKey(index),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Text(
                    msg,
                    style: const TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal),
                  ),
                )
        ]),
      ),
    );
