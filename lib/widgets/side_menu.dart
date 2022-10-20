import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/locator.dart';
import 'package:flutter_web_dashboard/routing/router.dart';
import 'package:flutter_web_dashboard/services/navigation_service.dart';
import 'package:flutter_web_dashboard/widgets/custom_text.dart';
import 'package:flutter_web_dashboard/widgets/side_menu_item.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      color: light,
      child: ListView(
        children: [
          // if (ResponsiveWidget.isSmallScreen(context))
          //   Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       SizedBox(height: 40),
          //       Row(
          //         children: [
          //           SizedBox(width: _width / 48),
          //           Padding(
          //             padding: const EdgeInsets.only(right: 12),
          //             child: Image.asset(
          //               "assets/images/2-removebg-preview.png",
          //               height: 50,
          //             ),
          //           ),
          //           Flexible(
          //             child: CustomText(
          //               text: "Dash",
          //               size: 20,
          //               weight: FontWeight.bold,
          //               color: active,
          //             ),
          //           ),
          //           SizedBox(width: _width / 48),
          //         ],
          //       ),
          //       SizedBox(
          //         height: 30,
          //       ),
          //     ],
          //   ),
          Divider(color: lightGrey.withOpacity(.1), thickness: 4),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItemRoutes

                .map((item) => SideMenuItem(
                    itemName: item.name,
                    onTap: () {
                      // if (item.route == authenticationPageRoute) {
                      //   Get.offAllNamed(authenticationPageRoute);
                      //   menuController.changeActiveItemTo(overviewPageDisplayName);
                      // }
                      // else if (item.route == usersPageRoute) {
                      //   Navigator.pushNamed(context, RoutesName.USERPAGE);
                      //   menuController.changeActiveItemTo(usersPageDisplayName);
                      // }
                      // else if (item.route == pricePageRoute) {
                      //   Navigator.pushNamed(context, RoutesName.PRICEPAGE);
                      //   menuController.changeActiveItemTo(pricePageDisplayName);
                      // }
                      // else if (item.route == timePagePageRoute) {
                      //   Navigator.pushNamed(context, RoutesName.TimePage);
                      //   menuController.changeActiveItemTo(timePageDisplayName);
                      // }
                      // else if (item.route == clientsPageRoute) {
                      //   Navigator.pushNamed(context, RoutesName.TimePage);
                      //   menuController.changeActiveItemTo(clientsPageDisplayName);
                      // }
                      // else if (item.route == recordPageRoute) {
                      //   Navigator.pushNamed(context, RoutesName.RecordPage);
                      //   menuController.changeActiveItemTo(recordPageDisplayName);
                      // }
                      // else if (item.route == helpChatPageRoute) {
                      //   Navigator.pushNamed(context, RoutesName.HELPCHATSCREEN);
                      //   menuController.changeActiveItemTo(helpChatPageDisplayName);
                      // }
                      //
                      //  else if (item.route == RoutesName.USERPAGE) {
                      //    Navigator.pushNamed(context, RoutesName.USERPAGE);
                      //    menuController.changeActiveItemTo(overviewPageDisplayName);
                      //  }

                      ResponsiveWidget.isSmallScreen(context) ? NavigationService.goBack() : null;
                      locator<NavigationService>().navigateTo(item.route);
                      // locator<NavigationService>().navigateTo(timePagePageRoute);

                      if (!menuController.isActive(item.name)) {
                        menuController.changeActiveItemTo(item.name);
                        if (ResponsiveWidget.isSmallScreen(context)) Get.back();
                        // NavigationService.navigateTo(item.route);
                        locator<NavigationService>().navigateTo(item.route);
                      }
                    }))
                .toList(),
          )
        ],
      ),
    );
  }
}
