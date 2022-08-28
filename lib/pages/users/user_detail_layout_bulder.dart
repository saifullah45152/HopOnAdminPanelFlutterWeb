import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/model/driver_model.dart';
import 'package:flutter_web_dashboard/pages/users/user_detail_large.dart';
import 'package:flutter_web_dashboard/pages/users/user_detail_small.dart';

class UserLayOutScreen extends StatelessWidget {
  DriverModel? driverModel;
  UserLayOutScreen({Key? key, this.driverModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.minWidth > 600) {
          return UserDetailLarge(driverModel: driverModel);
        } else {
          return UserDetailSmall(driverModel: driverModel);
        }
      },
    );
  }
}