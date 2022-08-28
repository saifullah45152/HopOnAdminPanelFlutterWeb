import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/help_chat/chat_head_large_screen.dart';
import 'package:flutter_web_dashboard/pages/help_chat/chat_head_small_screen.dart';

class ChatHelpLayOutBuilder extends StatelessWidget {
  ChatHelpLayOutBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.minWidth > 600) {
          return ChatHeadLargeScreen( );
        } else {
          return ChatHeadSmallScreen( );
        }
      },
    );
  }
}