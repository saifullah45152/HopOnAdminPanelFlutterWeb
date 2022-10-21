import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/help_chat/chat_head_large_screen.dart';
import 'package:flutter_web_dashboard/pages/help_chat/chat_head_small_screen.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ChatHelpLayOutBuilder extends StatelessWidget {
  ChatHelpLayOutBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return ChatHeadLargeScreen();
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return ChatHeadLargeScreen();
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return ChatHeadSmallScreen();
        }

        return Container(color: Colors.purple);
      },
    );
  }
}
