import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/pages/overview/overview.dart';

class LargeScreen extends StatelessWidget {
  final Widget? child;
  const LargeScreen({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Expanded(child: SideMenu()),
        Expanded(
          flex: 5,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            // child: localNavigator(),
            child: OverviewPage(),
            // Navigator(
            //   key: navigationController.navigatorKey,
            // onGenerateRoute: generateRoute,
            //
            //   initialRoute: overviewPageRoute,
            // ),
          ),
        )
      ],
    );
  }
}
