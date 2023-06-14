import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String text;
  double? fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  CustomText(
    this.text, {
    Key? key,
    this.maxLines,
    this.color = Colors.white,
    this.fontSize,
    this.fontWeight = FontWeight.w400,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.clip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize ?? 16.sp,
        fontWeight: fontWeight,
        // fontFamily: 'Inter',
        overflow: overflow,
      ),
      textAlign: textAlign,
    );
  }
}
