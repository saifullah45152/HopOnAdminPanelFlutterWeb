import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  String? data;
  SecondPage({this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        children: [
          Container(
            child: const Center(
              child: Text("SECOND PAGE"),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigator.pushNamed(context, RoutesName.SECOND_PAGE);
              },
              child: const Text("NAVIGATE")),
          Text(data!),
        ],
      ),
    );
  }
}
