import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/pages/help_chat/chat_help_layout_builder.dart';
import 'package:flutter_web_dashboard/pages/help_chat/chat_head_small_screen.dart';
import 'package:flutter_web_dashboard/pages/record/record_table.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:get/get.dart';

class HelpChatPage extends StatelessWidget {
  const HelpChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Obx(
                () => Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ChatHelpLayOutBuilder(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}