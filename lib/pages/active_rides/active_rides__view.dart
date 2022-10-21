import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/active_rides/active_ride_page_small.dart';
import 'package:flutter_web_dashboard/pages/active_rides/activeride_page_large.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ActiveRidesView extends StatelessWidget {
  const ActiveRidesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return ActiveRidelargeScreen();
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return ActiveRidelargeScreen();
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return ActiveRidesSmallScreen();
        }

        return Container(color: Colors.purple);
      },
    );
  }
}
