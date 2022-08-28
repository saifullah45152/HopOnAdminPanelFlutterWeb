import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/active_driver/active_driver_page.dart';
import 'package:flutter_web_dashboard/pages/clients/clients.dart';
import 'package:flutter_web_dashboard/pages/help_chat/help_chat_page.dart';
import 'package:flutter_web_dashboard/pages/overview/overview.dart';
import 'package:flutter_web_dashboard/pages/price/price_page.dart';
import 'package:flutter_web_dashboard/pages/record/record_page.dart';
import 'package:flutter_web_dashboard/pages/reservations/reservation_page.dart';
import 'package:flutter_web_dashboard/pages/time/time.dart';
import 'package:flutter_web_dashboard/pages/users/users.dart';

const rootRoute = "/";

const overviewPageDisplayName = "Overview";
const overviewPageRoute = "/overview";

const usersPageDisplayName = "Users";
const usersPageRoute = "/users";

const pricePageDisplayName = "Price";
const pricePageRoute = "/price";


const clientsPageDisplayName = "Clients";
const clientsPageRoute = "/clients";

const timePageDisplayName = "Time";
const timePagePageRoute = "/time";

const ActiveDriverPageDisplayName = "ActiveDriver";
const activeDriverPagePageRoute = "/activedriver";

const ReservationsPageDisplayName = "Reservations";
const reservationPagePageRoute = "/reservations";

const recordPageDisplayName = "Record";
const recordPageRoute = "/record";

const helpChatPageDisplayName = "HelpChat";
const helpChatPageRoute = "/helpchat";

const authenticationPageDisplayName = "Log out";
const authenticationPageRoute = "/auth";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItemRoutes = [
  MenuItem(overviewPageDisplayName, overviewPageRoute),
  MenuItem(usersPageDisplayName, usersPageRoute),
  MenuItem(pricePageDisplayName, pricePageRoute),
  MenuItem(timePageDisplayName, timePagePageRoute),
  MenuItem(clientsPageDisplayName, clientsPageRoute),
  MenuItem(ActiveDriverPageDisplayName, activeDriverPagePageRoute),
  MenuItem(ReservationsPageDisplayName, reservationPagePageRoute),
  MenuItem(recordPageDisplayName, recordPageRoute),
  MenuItem(helpChatPageDisplayName, helpChatPageRoute),

  //logout
  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];

//++---------------------------------------------------------------
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(OverviewPage());
    case usersPageRoute:
      return _getPageRoute(UserPage());
    case pricePageRoute:
      return _getPageRoute(PricePage());
    case timePagePageRoute:
      return _getPageRoute((TimePage()));
    case clientsPageRoute:
      return _getPageRoute(ClientsPage());
    case activeDriverPagePageRoute:
      return _getPageRoute((ActiveDriverPage()));
    case reservationPagePageRoute:
      return _getPageRoute((Reservation()));
    case recordPageRoute:
      return _getPageRoute((RecordPage()));
    case helpChatPageRoute:
      return _getPageRoute((HelpChatPage()));

    // default
    default:
      return _getPageRoute(OverviewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}