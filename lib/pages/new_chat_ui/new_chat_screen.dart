import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/widgets/my_text_widget.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class NewChatScreen extends StatelessWidget {
  List<Map<String, dynamic>> dummyMsg = [
    for (int i = 0; i < 10; i++)
      {
        'msg': 'Fine.',
        'time': '10:02 p.m',
        'senderType': i.isEven ? 'me' : 'receiver',
      },
  ];

  List<Map<String, dynamic>> get getDummyMsg => dummyMsg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        leadingWidth: 110,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/images/profile.jpg',
                height: 45,
                width: 45,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        title: MyText(
          text: 'Name',
          weight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            physics: const BouncingScrollPhysics(),
            itemCount: dummyMsg.length,
            itemBuilder: (context, index) {
              var data = dummyMsg[index];
              return ChatBubble(
                msg: data['msg'],
                time: data['time'],
                senderType: data['senderType'],
              );
            },
          ),
          SendField(
            hintText: 'type here...',
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ChatBubble extends StatelessWidget {
  ChatBubble({
    Key? key,
    this.msg,
    this.time,
    this.isSeen,
    this.senderType,
  }) : super(key: key);

  String? msg, time, senderType;
  bool? isSeen;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment:
            senderType == 'receiver' ? Alignment.topLeft : Alignment.topRight,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: senderType == 'receiver' ? kPrimaryColor : kSecondaryColor,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                offset: const Offset(0, 1),
                blurRadius: 4,
              ),
            ],
          ),
          margin: const EdgeInsets.only(bottom: 30),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10.0,
            children: [
              MyText(
                text: '$msg',
                color: senderType == 'receiver' ? KSecondaryColor : kPrimaryColor,
              ),
              MyText(
                text: '$time',
                color: senderType == 'receiver' ? KSecondaryColor : kPrimaryColor,
                size: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ignore: must_be_immutable
class SendField extends StatelessWidget {
  SendField({
    Key? key,
    this.hintText,
    this.sendFieldController,
  }) : super(key: key);

  String? hintText;
  TextEditingController? sendFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
        height: 80,
        width: Get.width,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              offset: const Offset(0, -1),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                controller: sendFieldController,
                cursorColor: kSecondaryColor,
                style: const TextStyle(
                  fontSize: 14,
                  color: KSecondaryColor,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  suffixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/send_button.png',
                        height: 18,
                      ),
                    ],
                  ),
                  hintText: hintText,
                  filled: true,
                  fillColor: kPrimaryColor,
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: KSecondaryColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: KSecondaryColor.withOpacity(0.1),
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: KSecondaryColor.withOpacity(0.1),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}