// ignore_for_file: must_be_immutable, file_names

import 'package:firestore/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  String name;
  void Function()? onTap;
  double height;
  double width;
  CustomButton(
    this.name,
    this.onTap, {
    this.height = 30,
    this.width = 30,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        InkWell(
          onTap: onTap,
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.red[400],
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Center(
              child: CustomText(
                name,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
