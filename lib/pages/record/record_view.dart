import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/record/record_page_large.dart';
import 'package:flutter_web_dashboard/pages/record/record_page_small.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RecordView extends StatelessWidget {
  const RecordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return RecordPageLarge();
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return RecordPageLarge();
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return RecordPageSmall();
        }

        return Container(color: Colors.purple);
      },
    );
  }
}
