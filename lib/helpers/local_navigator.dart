import 'package:flutter/cupertino.dart';
import 'package:flutter_web_dashboard/constants/controllers.dart';
import 'package:flutter_web_dashboard/routing/router.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: overviewPageRoute,
    );
