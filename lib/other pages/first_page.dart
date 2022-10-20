import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/routing/router.dart';

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    log("First Page ");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        children: [
          const Center(
            child: Text("FIRST PAGE"),
          ),
          TextButton(
              onPressed: () {
                // Navigator.pushNamed(context, RoutesName.SECOND_PAGE, arguments: "Text From First Page ");
              },
              child: const Text("NAVIGATE")),
        ],
      ),
    );
  }
}
