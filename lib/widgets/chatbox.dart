import 'package:firestore/utils/colors.dart';
import 'package:firestore/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBox extends StatelessWidget {
  bool isUserMe;
  String avatar;
  String userName;
  String? time;
  String? messageBody;
  ChatBox({
    required this.isUserMe,
    this.userName = 'User',
    required this.messageBody,
    required this.avatar,
    this.time,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isUserMe ? const Expanded(child: SizedBox()) : const SizedBox(),
        Container(
          // height: 48.h,
          width: 204.w,
          decoration: BoxDecoration(
            color: isUserMe ? AppColor.green : Colors.transparent,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: ListTile(
            dense: true,
            horizontalTitleGap: 0,
            minVerticalPadding: 5,
            leading: Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Container(
                height: 30.h,
                width: 30.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  image: DecorationImage(
                    image: AssetImage(avatar),
                  ),
                ),
              ),
            ),
            title: CustomText(
              isUserMe ? "It's Me" : userName,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: CustomText(
                messageBody!,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                maxLines: 5,
              ),
            ),
            trailing: Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: CustomText(
                time ?? '12:30',
                fontSize: 8.sp,
                fontWeight: FontWeight.w500,
                color: isUserMe ? AppColor.white : AppColor.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
