import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  static ChatController instance = Get.find();

  //
  addHelpChatConversationMessage(String chatRoomId, String type, messageMap, String msg) async {
    await ffstore
        .collection(helpChatRoomCollection)
        .doc(chatRoomId)
        .collection(helpChatMessageCollection)
        .add(messageMap)
        .then((value) async {
      await ffstore.collection(helpChatRoomCollection).doc(chatRoomId).update({
        'lastMessageAt': DateTime.now().millisecondsSinceEpoch,
        'lastMessage': msg,
        'lastMessageType': type,
      }).catchError((e) {
        log("Error is $e");
      });
    }).catchError((e) {});
  }

  //
  getChatRoomId(String userID, String anotherUserID) {
    print("inside getChatRoomId a = $userID & b = $anotherUserID");
    var chatRoomId;
    if (userID.compareTo(anotherUserID) > 0) {
      chatRoomId = '$userID - $anotherUserID';
    } else {
      chatRoomId = '$anotherUserID - $userID';
    }
    return chatRoomId;
  }

  getHelpChatConversationMessage(String chatRoomId) async {
    return ffstore
        .collection(helpChatRoomCollection)
        .doc(chatRoomId)
        .collection(helpChatMessageCollection)
        .orderBy('time')
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getAChatRoomInfo(String chatRoomId) async {
    return ffstore.collection(helpChatRoomCollection).doc(chatRoomId).get();
  }
}