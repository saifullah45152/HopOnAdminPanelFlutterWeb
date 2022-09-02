import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/widgets/my_text_widget.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

class HelpChatScreenSmall extends StatefulWidget {
  final docs;
  HelpChatScreenSmall({this.docs});
  @override
  _HelpChatScreenSmallState createState() => _HelpChatScreenSmallState();
}

class _HelpChatScreenSmallState extends State<HelpChatScreenSmall> {
  List<String> monthsList = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  TextEditingController msgController = TextEditingController();
  String? chatRoomID;
  String? userID;
  String? anotherUserName;
  String? anotherUserImage;
  String? anotherUserID;

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? chatRoomListener;

  Stream<QuerySnapshot>? chatMessageStream;
  ScrollController scrollController = ScrollController();
  RxInt lastIndex = 0.obs;
  RxString lastMessage = "".obs;
  RxInt lastMessageAt = 0.obs;

  //+Other

  @override
  void initState() {
    // isOpenedUp = true;
    getRoomId();
    super.initState();
    chatController.getHelpChatConversationMessage(chatRoomID!).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
  }

  getRoomId() async {
    anotherUserID = widget.docs['userId'];
    log("Other User id is =>  $anotherUserID");
    userID = adminId;
    //cureent user id (ADMIN ID ), another user id(Passenger or Driver Id)
    chatRoomID = chatController.getChatRoomId(userID!, anotherUserID!);
  }

  sendMessage() async {
    var messageText = msgController.text.trim();

    if (msgController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "sendById": adminId,
        "sendByName": "Admin",
        "receivedByName": "",
        "message": messageText,
        "type": "text",
        'time': DateTime.now().millisecondsSinceEpoch,
        "isRead": false,
        "isReceived": false,
        "sendat": DateTime.now(),
      };
      chatController.addHelpChatConversationMessage(chatRoomID!, "textMessage", messageMap, messageText);
      msgController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: EdgeInsets.only(bottom: 30),
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
          child: Container(
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 600),
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: chatMessageStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            WidgetsBinding.instance?.addPostFrameCallback((_) {
                              if (scrollController.hasClients) {
                                scrollController.jumpTo(
                                  scrollController.position.maxScrollExtent,
                                );
                              }
                            });
                            return GroupedListView<dynamic, String>(
                              elements: snapshot.data?.docs as List<dynamic>,

                              controller: scrollController,
                              sort: false,
                              scrollDirection: Axis.vertical,
                              itemComparator: (element1, element2) => element1['time'].compareTo(element2['time']),
                              floatingHeader: false,
                              groupBy: (dynamic element) =>
                              "${monthsList[DateTime.fromMillisecondsSinceEpoch(element['time']).month - 1]} "
                                  "${DateTime.fromMillisecondsSinceEpoch(element['time']).day}, "
                                  "${DateTime.fromMillisecondsSinceEpoch(element['time']).year}",
                              groupComparator: (String value1, String value2) => value2.compareTo(value1),
                              groupSeparatorBuilder: (dynamic element) {
                                log("Element $element");
                                bool isToday =
                                    "${monthsList[DateTime.now().month - 1]} ${DateTime.now().day}, ${DateTime.now().year}" ==
                                        element;
                                log("isToday $isToday");
                                final yesterday =
                                DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);
                                final yesterdayHere =
                                    "${monthsList[yesterday.month - 1]} ${yesterday.day}, ${yesterday.year}";
                                log("yesterdayHere $yesterdayHere");

                                final checkDate = element;
                                log("checkDate $checkDate");

                                return SizedBox(
                                  height: 35,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 35,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          !isToday
                                              ? checkDate == yesterdayHere
                                              ? "Yesterday"
                                              : element
                                              : "Today",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemBuilder: (context, dynamic element) {
                                lastIndex.value = snapshot.data!.docs.indexWhere((element) =>
                                (element["message"] == lastMessage.value &&
                                    element["time"] == lastMessageAt.value));

                                String type = element.data()["type"];
                                String message =
                                element.data()["message"] != null ? element.data()["message"] : "what is this?";
                                bool sendByMe = adminId == element.data()["sendById"];

                                if (!sendByMe) {
                                  element.reference.update({'isRead': true});
                                }

                                String time = element.data()["time"].toString();

                                var hour = DateTime.fromMillisecondsSinceEpoch(int.parse(time)).hour;
                                var min = DateTime.fromMillisecondsSinceEpoch(int.parse(time)).minute;
                                var ampm;
                                if (hour > 12) {
                                  hour = hour % 12;
                                  ampm = 'pm';
                                } else if (hour == 12) {
                                  ampm = 'pm';
                                } else if (hour == 0) {
                                  hour = 12;
                                  ampm = 'am';
                                } else {
                                  ampm = 'am';
                                }
                                switch (type) {
                                  case 'text':
                                    return (sendByMe)
                                        ? RightBubble(
                                      type: 'text',
                                      time: "${hour.toString()}:"
                                          "${(min.toString().length < 2) ? "0${min.toString()}" : min.toString()} "
                                          "${ampm}",
                                      msg: message,
                                      id: element.id,
                                      sendByMe: sendByMe,
                                      isRead: element['isRead'],
                                      isReceived: element['isReceived'],
                                    )
                                        : LeftBubble(
                                      personImage: anotherUserImage,
                                      type: 'text',
                                      time: "${hour.toString()}:"
                                          "${(min.toString().length < 2) ? "0${min.toString()}" : min.toString()} "
                                          "${ampm}",
                                      msg: message,
                                      id: element.id,
                                      sendByMe: sendByMe,
                                      isRead: element['isRead'],
                                      isReceived: element['isReceived'],
                                    );

                                  default:
                                    return Container();
                                }
                              },
                              order: GroupedListOrder.ASC, // optional
                            );
                          } else {
                            return Container(
                              child: Center(
                                child: Text("Loading...."),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white60,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: TextFormField(
                                    controller: msgController,
                                    decoration: InputDecoration(
                                      labelText: "Type here....",
                                      hintText: "Hello World",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () async {
                                      log("send message ");
                                      await sendMessage();
                                    },
                                    child: Image.asset(
                                      "assets/images/Vector - 2022-03-22T095409.334.png",
                                      height: 23,
                                      width: 23,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );

  }
}

class LeftBubble extends StatelessWidget {
  var personImage, time, msg, type, id, sendByMe;
  bool? isRead;
  bool? isReceived;

  LeftBubble({
    this.personImage,
    this.time,
    this.msg,
    this.type,
    this.id,
    this.sendByMe,
    this.isRead,
    this.isReceived,
  });

  RxBool isSelected = false.obs;

  @override
  Widget build(BuildContext context) {
    isSelected.value = false;
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 50, bottom: 10, top: 10),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Card(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: type == 'text' ? 13 : 0, vertical: type == 'text' ? 10 : 0),
            decoration: BoxDecoration(
              color: kPrimaryColor2,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 0),
                  blurRadius: 10,
                  color: Color(0xff111111).withOpacity(0.06),
                ),
              ],
            ),
            child: Wrap(
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                MyText(
                  text: msg,
                  size: 14,
                  color: Color(0xff434343),
                  paddingRight: 10,
                ),
                sendByMe
                    ? (!isRead! && !isReceived!)
                        ? Image.asset(
                            "assets/images/tick.png",
                            width: 14,
                            height: 14,
                            color: Colors.grey,
                          )
                        : Image.asset(
                            "assets/images/read.png",
                            width: 14,
                            height: 14,
                            color: (isReceived! && !isRead!) ? Colors.grey : Colors.blue,
                          )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RightBubble extends StatelessWidget {
  RightBubble({
    this.time,
    this.sendByMe,
    this.msg,
    this.type,
    this.id,
    this.isRead,
    this.isReceived,
  });

  var time, msg, type, id, sendByMe;
  bool? isRead = false;
  bool? isReceived = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: const EdgeInsets.only(left: 50, right: 10, bottom: 3, top: 3),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Card(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: KPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Wrap(
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                MyText(
                  text: msg,
                  size: 14,
                  color: Colors.black,
                  paddingRight: 10,
                  overFlow: TextOverflow.ellipsis,
                  align: TextAlign.justify,
                ),

                MyText(
                  text: time,
                  size: 12,
                  fontFamily: 'Roboto',
                  color: Colors.black,
                  weight: FontWeight.w500,
                ),
                // : SizedBox(),
                sendByMe
                    ? (!isRead! && !isReceived!)
                        ? Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Image.asset(
                              "assets/images/tick.png",
                              width: 14,
                              height: 10,
                              color: Colors.grey,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Image.asset(
                              "assets/images/read.png",
                              width: 14,
                              height: 14,
                              color: (isReceived! && (!isRead!)) ? Colors.grey : Colors.blue,
                            ),
                          )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
