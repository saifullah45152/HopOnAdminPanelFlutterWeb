import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/pages/new_chat_ui/new_chat_screen.dart';
import 'package:get/get.dart';

class NewChatUI extends StatelessWidget {
  //Chat HEAD
  List<Map<String, dynamic>> chatHeadsData = [
    for (int i = 0; i < 10; i++)
      {
        'imgUrl': 'assets/images/profile.jpg',
        'name': 'Name $i',
        'lastMsg': 'Last Msg $i',
      }
  ];

  //Chat ROOMS
  List<Widget> children = [
    for (int i = 0; i < 10; i++) NewChatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: chatHeadsData.length,
        initialIndex: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RotatedBox(
              quarterTurns: 1,
              child: Container(
                color: kPrimaryColor,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: KSecondaryColor.withOpacity(0.1),
                    highlightColor: KSecondaryColor.withOpacity(0.1),
                  ),
                  child: TabBar(
                    isScrollable: true,
                    tabs: List.generate(
                      chatHeadsData.length,
                      (index) {
                        var data = chatHeadsData[index];
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 320,
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    data['imgUrl'],
                                    height: 45,
                                    width: 45,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(
                                  data['name'],
                                ),
                                subtitle: Text(
                                  data['lastMsg'],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
