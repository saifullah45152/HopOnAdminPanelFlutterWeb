import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/layout.dart';
import 'package:flutter_web_dashboard/pages/0_authentication/authentication.dart';
import 'package:flutter_web_dashboard/pages/2_users/user_detail_layout_bulder.dart';
import 'package:flutter_web_dashboard/pages/2_users/users.dart';
import 'package:flutter_web_dashboard/pages/404/error.dart';
import 'package:flutter_web_dashboard/pages/active_rides/active_rides__view.dart';
import 'package:flutter_web_dashboard/pages/help_chat/help_chat_page.dart';
import 'package:flutter_web_dashboard/pages/overview/overview.dart';
import 'package:flutter_web_dashboard/pages/price/price_page.dart';
import 'package:flutter_web_dashboard/pages/record/record_view.dart';
import 'package:flutter_web_dashboard/pages/reservations/reservation_view.dart';
import 'package:flutter_web_dashboard/pages/time/time.dart';
import 'package:flutter_web_dashboard/routing/routes_names.dart';



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
  MenuItem(ActiveRidesPageDisplayName, activeRidesPagePageRoute),
  MenuItem(ReservationsPageDisplayName, reservationPagePageRoute),
  MenuItem(recordPageDisplayName, recordPageRoute),
  MenuItem(helpChatPageDisplayName, helpChatPageRoute),
  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
  //
  // MenuItem(clientsPageDisplayName, clientsPageRoute),
];

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPageRouteName:
        return _getPageRoute(LoginPage(), settings);
      case siteLayOutPageRoute:
        return _getPageRoute(SiteLayout(), settings);
      case overviewPageRoute:
        return _getPageRoute(OverviewPage(), settings);
      case usersPageRoute:
        return _getPageRoute(UserPage(), settings);
      case pricePageRoute:
        return _getPageRoute(PricePage(), settings);
      case timePagePageRoute:
        return _getPageRoute(TimePage(), settings);
      case activeRidesPagePageRoute:
        return _getPageRoute(ActiveRidesView(), settings);
      case recordPageRoute:
        return _getPageRoute(RecordView(), settings);
        case reservationPagePageRoute:
        return _getPageRoute(ReservationView(), settings);
      case userLayOutPage:
        return _getPageRoute(UserLayOutScreen(), settings);
      case helpChatPageRoute:
        return _getPageRoute(HelpChatPage(), settings);
      default:
        return _getPageRoute(PageNotFound(), settings);
    }
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name ?? "");
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String? routeName;
  _FadeRoute({required this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(opacity: animation, child: child),
        );
}
