import 'package:flutter/material.dart';

class ScreenHandler extends StatelessWidget {
  final Widget? child;
  const ScreenHandler({Key? key, this.child}) : super(key: key);

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
            child: child,
          ),
        )
      ],
    );
  }
}
