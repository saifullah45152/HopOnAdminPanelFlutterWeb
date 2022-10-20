import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/centered_view.dart';
import 'package:flutter_web_dashboard/helpers/reponsiveness.dart';
import 'package:flutter_web_dashboard/widgets/side_menu.dart';
import 'package:flutter_web_dashboard/widgets/top_nav.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LayoutTemplate extends StatelessWidget {
  final Widget? child;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  LayoutTemplate({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        key: scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: topNavigationBar(context, scaffoldKey),
        drawer: Drawer(child: SideMenu()),

        // drawer: sizingInformation.deviceScreenType == DeviceScreenType.mobile ? const NavigationDrawer() : null,
        backgroundColor: Colors.white,
        body: Row(
          children: <Widget>[
            ResponsiveWidget.isSmallScreen(context) ? Container() : Expanded(child: SideMenu()),
            // Container(color: Colors.green, width: 50),
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: child,
              ),
            )
          ],
        ),
      ),
    );
  }
}
