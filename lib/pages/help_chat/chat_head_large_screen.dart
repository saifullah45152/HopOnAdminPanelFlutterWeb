import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/model/chat_head_model.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';

/// Example without datasource
class ChatHeadLargeScreen extends StatefulWidget {
  @override
  State<ChatHeadLargeScreen> createState() => _ChatHeadLargeScreenState();
}

class _ChatHeadLargeScreenState extends State<ChatHeadLargeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: active.withOpacity(.4), width: .5),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 6),
            color: lightGrey.withOpacity(.1),
            blurRadius: 12,
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 30),
      child: Container(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 600),
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: CustomText(
                    text: "Help Chat Large Scree ",
                    weight: FontWeight.bold,
                    size: 20,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: ffstore
                        .collection(helpChatRoomCollection)
                        // .where('users', arrayContains: "mLf1kOG0WqXe3pDCbhEFB44Px7w2")
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox();
                      } else if (snapshot.connectionState == ConnectionState.active ||
                          snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              Rx<ChatHeadModel> data = ChatHeadModel().obs;
                              QueryDocumentSnapshot<Object?>? doc = snapshot.data?.docs[index];

                              data.value = ChatHeadModel.fromDocumentSnapshot(doc!);
                              return Obx(() {
                                return ReadMessage(
                                  img: data.value.userImg,
                                  chatRoomId: data.value.chatRoomId,
                                  message: data.value.lastMessage,
                                  name: data.value.username,
                                  time: data.value.lastMessageAt,
                                );
                              });
                            },
                          );
                        } else {
                          log("in else of hasData done and: ${snapshot.connectionState} and"
                              " snapshot.hasData: ${snapshot.hasData}");
                          return SizedBox();
                        }
                      } else {
                        log("in last else of ConnectionState.done and: ${snapshot.connectionState}");
                        return SizedBox();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReadMessage extends StatefulWidget {
  const ReadMessage({
    this.img,
    this.chatRoomId,
    this.name,
    this.message,
    this.time,
  });

  final img;
  final chatRoomId;
  final name;
  final message;
  final time;

  @override
  _ReadMessageState createState() => _ReadMessageState();
}

class _ReadMessageState extends State<ReadMessage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var chatRoomMap;
        chatRoomMap = await chatController.getAChatRoomInfo(widget.chatRoomId);
        //+COmmented
        // Navigator.pushNamed(context, RoutesName.HELPCHATSCREEN,
        //     arguments: chatRoomMap);
        // Get.to(() => HelpChatScreenSmall(docs: chatRoomMap), transition: Transition.leftToRight);
      },
      child: Card(
        margin: EdgeInsets.all(6),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: Get.width * 0.8,
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              widget.img,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    title: Container(
                        width: Get.width * 0.30,
                        child: Text(
                          widget.name,
                          style: BlackSmallStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        )),
                    subtitle: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: ffstore
                          .collection(helpChatRoomCollection)
                          .doc(widget.chatRoomId)
                          .collection(helpChatMessageCollection)
                          .where("isRead", isEqualTo: false)
                          // .where("receivedById", isEqualTo: authController.passengerModel.value.currentUserId)
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        log("inside streambuilder");
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          log("inside streambuilder in waiting state");
                          return Text(
                            widget.message,
                            style: GreyLightTextSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        } else if (snapshot.connectionState == ConnectionState.active ||
                            snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const Text('Error');
                          } else if (snapshot.hasData) {
                            if (snapshot.data!.docs.length > 0) {
                              return Text(
                                widget.message,
                                style: BlackSmallTextStyle,
                                // style: TextStyle(color: Colors.pink),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              );
                            } else {
                              return Text(
                                widget.message,
                                style: GreyLightTextSmall,
                                // style: TextStyle(color: Colors.orange),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              );
                            }
                          } else {
                            log("in else of hasData done and: ${snapshot.connectionState} and"
                                " snapshot.hasData: ${snapshot.hasData}");
                            return SizedBox();
                          }
                        } else {
                          log("in last else of ConnectionState.done and: ${snapshot.connectionState}");
                          return SizedBox();
                        }
                      },
                    ),
                    trailing: Expanded(
                      child: Text(
                        DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(widget.time)).inMinutes < 60
                            ? "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(widget.time)).inMinutes} m ago"
                            : DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(widget.time)).inHours < 24
                                ? "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(widget.time)).inHours} hrs ago"
                                : "${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(widget.time)).inDays} days ago",
                        style: GreyLightTextSmall,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
