// import 'package:flutter/material.dart';
// import 'package:flutter_web_dashboard/helpers/local_navigator.dart';
// import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
// import 'package:flutter_web_dashboard/widgets/large_screen.dart';
// import 'package:flutter_web_dashboard/widgets/side_menu.dart';
//
// import 'widgets/top_nav.dart';
//
// class SiteLayout extends StatelessWidget {
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       extendBodyBehindAppBar: true,
//       appBar: topNavigationBar(context, scaffoldKey),
//       // drawer: Drawer(
//       //   child: SideMenu(),
//       // ),
//       body: ResponsiveWidget(
//         largeScreen: LargeScreen(),
//         mediumScreen: LargeScreen(),
//         smallScreen: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: localNavigator(),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/widgets/side_menu.dart';

import 'widgets/top_nav.dart';

class SiteLayout extends StatelessWidget {
  final Widget? child;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  SiteLayout({Key? key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: topNavigationBar(context, scaffoldKey),
      drawer: Drawer(child: SideMenu()),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: SideMenu()),
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: child,
            ),
          )
        ],
      ),
    );
  }
}
