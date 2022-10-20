import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';

import 'custom_text.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) {
  return AppBar(
    leading: !ResponsiveWidget.isSmallScreen(context)
        ? Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Image.asset(
                  "assets/images/2-removebg-preview.png",
                  width: 32,
                  height: 30,
                ),
              ),
            ],
          )
        : IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              key.currentState?.openDrawer();
            }),
    title: Container(
      child: Row(
        children: [
          Visibility(
              visible: !ResponsiveWidget.isSmallScreen(context),
              child: CustomText(
                text: "DashBoard",
                color: lightGrey,
                size: 20,
                weight: FontWeight.bold,
              )),
          Expanded(child: Container()),
        ],
      ),
    ),
    iconTheme: IconThemeData(color: dark),
    elevation: 0,
    backgroundColor: Colors.transparent,
  );
}
