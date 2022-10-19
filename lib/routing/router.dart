import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/layout.dart';
import 'package:flutter_web_dashboard/other%20pages/first_page.dart';
import 'package:flutter_web_dashboard/other%20pages/second_page.dart';
import 'package:flutter_web_dashboard/pages/active_driver/active_driver_page.dart';
import 'package:flutter_web_dashboard/pages/authentication/authentication.dart';
import 'package:flutter_web_dashboard/pages/clients/clients.dart';
import 'package:flutter_web_dashboard/pages/help_chat/chat_screen_small.dart';
import 'package:flutter_web_dashboard/pages/help_chat/help_chat_page.dart';
import 'package:flutter_web_dashboard/pages/overview/overview.dart';
import 'package:flutter_web_dashboard/pages/price/price_page.dart';
import 'package:flutter_web_dashboard/pages/record/record_page.dart';
import 'package:flutter_web_dashboard/pages/reservations/reservation_page.dart';
import 'package:flutter_web_dashboard/pages/time/time.dart';
import 'package:flutter_web_dashboard/pages/users/user_detail_layout_bulder.dart';
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
  //+Commented
  // MenuItem(ActiveDriverPageDisplayName, activeDriverPagePageRoute),
  // MenuItem(ReservationsPageDisplayName, reservationPagePageRoute),
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

//+New-------------------------------------------------------------------------------------------------------------------------------

class RoutesName {
  static const String FIRST_PAGE = '/first_page';
  static const String SECOND_PAGE = '/second_page';
  static const String LOGIN_PAGE = '/login_page';
  static const String SITELAYOUT = '/SiteLayout';
  static const String USERPAGE = '/user_page';
  static const String PRICEPAGE = '/price_page';
  static const String TimePage = '/time_page';
  static const String RecordPage = '/record_page';
  static const String USERLAYOUTBUILDER = '/userLayOutBuilder_page';
  static const String HELPCHATSCREEN = '/helpchatscreen_page';
  static const String OVERVIEW_PAGE = '/overview_page';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.LOGIN_PAGE:
        return GeneratePageRoute(widget: LoginPage(), routeName: settings.name);
      case RoutesName.SITELAYOUT:
        return GeneratePageRoute(widget: SiteLayout(), routeName: settings.name);
      //overView
      case RoutesName.OVERVIEW_PAGE:
        return GeneratePageRoute(widget: OverviewPage(), routeName: settings.name);
      //User Page
      case RoutesName.USERPAGE:
        return GeneratePageRoute(widget: UserPage(), routeName: settings.name);
      //Price Page
      case RoutesName.PRICEPAGE:
        return GeneratePageRoute(widget: PricePage(), routeName: settings.name);
      //Time Page
      case RoutesName.TimePage:
        return GeneratePageRoute(widget: TimePage(), routeName: settings.name);
     //Record Page
      case RoutesName.RecordPage:
        return GeneratePageRoute(widget: RecordPage(), routeName: settings.name);
      //User LayOutBuilder  Page
      case RoutesName.USERLAYOUTBUILDER:
        return GeneratePageRoute(widget: UserLayOutScreen(), routeName: settings.name);

      //User helpchatScreen  Page
      case RoutesName.HELPCHATSCREEN:
        return GeneratePageRoute(widget: HelpChatScreenSmall(), routeName: settings.name);
      //firrst page
      case RoutesName.FIRST_PAGE:
        return GeneratePageRoute(widget: FirstPage(), routeName: settings.name);

      case RoutesName.SECOND_PAGE:
        var data = settings.arguments as String;
        return GeneratePageRoute(widget: SecondPage(data: data), routeName: settings.name);
      default:
        return GeneratePageRoute(widget: SiteLayout(), routeName: settings.name);
    }
  }
}












class GeneratePageRoute extends PageRouteBuilder {
  final Widget? widget;
  final String? routeName;
  GeneratePageRoute({this.widget, this.routeName})
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
              return widget ?? Container();
            },
            transitionDuration: Duration(milliseconds: 100),
            transitionsBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation, Widget child) {
              return SlideTransition(
                textDirection: TextDirection.rtl,
                position: Tween<Offset>(
                  begin: Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            });
}
