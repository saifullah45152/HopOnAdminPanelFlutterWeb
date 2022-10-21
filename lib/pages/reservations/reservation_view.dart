import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/reservations/reservation_page_large.dart';
import 'package:flutter_web_dashboard/pages/reservations/reservation_page_small.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ReservationView extends StatelessWidget {
  const ReservationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return ReservationPageLarge();
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return ReservationPageLarge();
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return ReservationPageSmall();
        }

        return Container(color: Colors.purple);
      },
    );
  }
}
