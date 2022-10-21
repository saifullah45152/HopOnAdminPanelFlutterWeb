import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_web_dashboard/constants/style.dart';
import 'package:flutter_web_dashboard/controllers/chat_controller.dart';
import 'package:flutter_web_dashboard/controllers/menu_controller.dart';
import 'package:flutter_web_dashboard/controllers/navigation_controller.dart';
import 'package:flutter_web_dashboard/firebase_options.dart';
import 'package:flutter_web_dashboard/layout.dart';
import 'package:flutter_web_dashboard/locator.dart';

import 'package:flutter_web_dashboard/pages/record/record_view.dart';
import 'package:flutter_web_dashboard/routing/router.dart';
import 'package:flutter_web_dashboard/routing/routes_names.dart';
import 'package:flutter_web_dashboard/services/navigation_service.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  setupLocator();

  Get.put(MenuController());
  Get.put(NavigationController());
  Get.put(ChatController());
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBGhmEZRI81g1Mf0DTMH-Mj2zVIPkM2bUg",
        authDomain: "hop-on-85d9b.firebaseapp.com",
        databaseURL: "https://hop-on-85d9b-default-rtdb.firebaseio.com",
        projectId: "hop-on-85d9b",
        storageBucket: "hop-on-85d9b.appspot.com",
        messagingSenderId: "1020227698379",
        appId: "1:1020227698379:web:c4b39e75fae0dd7ae9654e",
        measurementId: "G-5BCFMKK7BK",
      ),
    );
  } else {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (BuildContext context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dashboard',
          theme: ThemeData(
            scaffoldBackgroundColor: light,
            textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Open Sans'),
            // textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.black),
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            }),
            primarySwatch: Colors.blue,
          ),
          builder: (context, child) => SiteLayout(child: child),
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: loginPageRouteName,
        );
      },
    );
  }
}
