import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/active_drivers/active_driver_large_screen.dart';
import 'package:flutter_web_dashboard/pages/active_drivers/active_driver_small_screen.dart';
import 'package:flutter_web_dashboard/pages/record/record_page_large.dart';
import 'package:flutter_web_dashboard/pages/record/record_page_small.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ActiveDriverView extends StatelessWidget {
  const ActiveDriverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return ActiveDriverLargeScreen();
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return ActiveDriverSmallScreen();
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return ActiveDriverSmallScreen();
        }

        return Container(color: Colors.purple);
      },
    );
  }
}
