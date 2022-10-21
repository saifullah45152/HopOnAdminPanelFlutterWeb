import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_dashboard/constants/style.dart';

class MyText extends StatelessWidget {
  var text, color, weight, align, decoration, fontFamily, fontStyle;
  double? size, wordSpacing, letterSpacing;
  double paddingTop, paddingLeft, paddingRight, paddingBottom;
  double? height;
  var maxlines, overFlow;
  VoidCallback? onTap;

  MyText({
    Key? key,
    this.onTap,
    this.text,
    this.size,
    this.fontStyle,
    this.wordSpacing = 1,
    this.letterSpacing = 1,
    this.maxlines = 100,
    this.decoration = TextDecoration.none,
    this.color = kGreyColor,
    this.weight = FontWeight.w400,
    this.align,
    this.height,
    this.overFlow,
    this.fontFamily,
    this.paddingTop = 0,
    this.paddingRight = 0,
    this.paddingLeft = 0,
    this.paddingBottom = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop,
        left: paddingLeft,
        right: paddingRight,
        bottom: paddingBottom,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          "$text",
          style: TextStyle(
            fontStyle: fontStyle,
            fontSize: size,
            wordSpacing: wordSpacing,
            color: color,
            letterSpacing: letterSpacing,
            fontWeight: weight,
            decoration: decoration,
            height: height,
          ),
          textAlign: align,
          maxLines: maxlines,
          overflow: overFlow,
        ),
      ),
    );
  }
}
