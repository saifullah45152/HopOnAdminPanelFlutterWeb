import 'package:cloud_firestore/cloud_firestore.dart';

class ChatHeadModel {
  String? chatRoomId;
  String? userId;
  String? lastMessage;
  var lastMessageAt;
  String? lastMessageType;
  String? username;
  String? userImg;

  ChatHeadModel();

  ChatHeadModel.fromDocumentSnapshot(QueryDocumentSnapshot doc) {
    chatRoomId = doc["chatRoomId"];
    userId = doc["userId"];
    username = doc["username"];
    lastMessage = doc["lastMessage"];
    lastMessageAt = doc["lastMessageAt"];
    userImg = doc["userImg"];
  }
}