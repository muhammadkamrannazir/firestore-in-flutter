import 'package:firestore/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_text.dart';

Widget resetPageDialog() {
  return Dialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 23.w),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    child: SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 28.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    // Get.to(Login());
                  },
                  icon: const Icon(
                    Icons.close,
                  ),
                )
              ],
            ),
          ),
          // Image(
          //   height: 64.17.h,
          //   width: 78.17.w,
          //   image: AssetImage(email),
          // ),
          SizedBox(height: 17.h),
          CustomText(
            'Check Your Email',
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 12.h),
          CustomText(
            'A Password Reset Link Is Sent To Your Email',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.grey,
          ),
          SizedBox(height: 50.h),
        ],
      ),
    ),
  );
}
