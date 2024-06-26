import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/model/driver_model.dart';
import 'package:flutter_web_dashboard/pages/2_users/user_detail_large.dart';
import 'package:flutter_web_dashboard/pages/2_users/user_detail_small.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UserLayOutScreen extends StatelessWidget {
  DriverModel? driverModel;
  UserLayOutScreen({Key? key, this.driverModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return UserDetailLarge(driverModel: driverModel);
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return UserDetailLarge(driverModel: driverModel);
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return UserDetailSmall(driverModel: driverModel);
        }

        return Container(color: Colors.purple);
      },
    );
  }
}
