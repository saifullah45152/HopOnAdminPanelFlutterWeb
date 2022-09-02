import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/routing/router.dart';
import 'package:get/get.dart';
import 'dart:developer';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = overviewPageDisplayName.obs;

  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isHovering(String itemName) => hoverItem.value == itemName;

  isActive(String itemName) => activeItem.value == itemName;

  Widget returnIconFor(String itemName) {
    log("item name is menu_controller  $itemName");

    switch (itemName) {
      //overView
      case overviewPageDisplayName:
        return _customIcon(Icons.trending_up, itemName);
      case usersPageDisplayName:
        return _customIcon(Icons.people_alt_outlined, itemName);
      case pricePageDisplayName:
        return _customIcon(Icons.price_change, itemName);
      case timePageDisplayName:
        return _customIcon(Icons.timer, itemName);
      case clientsPageDisplayName:
        return _customIcon(Icons.people_alt_outlined, itemName);
      case ActiveDriverPageDisplayName:
        return _customIcon(Icons.drive_eta, itemName);
      case ReservationsPageDisplayName:
        return _customIcon(Icons.drive_eta, itemName);
      case helpChatPageDisplayName:
        return _customIcon(Icons.help_outlined, itemName);
      case recordPageDisplayName:
        return _customIcon(Icons.history_rounded, itemName);
      case authenticationPageDisplayName:
        return _customIcon(Icons.exit_to_app, itemName);
      default:
        return _customIcon(Icons.clear, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) {
      return Icon(icon, size: 22, color: dark);
    }
    return Icon(
      icon,
      color: isHovering(itemName) ? dark : lightGrey,
    );
  }
}
