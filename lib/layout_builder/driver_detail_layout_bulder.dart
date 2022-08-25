import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/model/driver_model.dart';
import 'package:flutter_web_dashboard/pages/drivers/diver_detail_small.dart';
import 'package:flutter_web_dashboard/pages/drivers/driver_detail_large.dart';

class LayoutScreen extends StatelessWidget {
  DriverModel? driverModel;
  LayoutScreen({Key? key, this.driverModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.minWidth > 600) {
          return DriverDetailLarge(driverModel: driverModel);
        } else {
          return DriverDetailSmall(driverModel: driverModel);
        }
      },
    );
  }
}