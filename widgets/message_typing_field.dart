import 'package:firestore/utils/colors.dart';
import 'package:firestore/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageTypingField extends StatelessWidget {
  void Function(String)? onChanged;
  void Function()? send;
  final TextEditingController? controller;
  MessageTypingField({
     this.onChanged,
     this.send,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      cursorColor: AppColor.green,
      cursorHeight: 25,
      decoration: InputDecoration(
        hintText: 'Type a message',
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: 2.w),
          child: IconButton(
            icon: const Icon(Icons.send),
            onPressed: send,
          ),
        ),
        hintStyle: const TextStyle(
          color: AppColor.greydark,
        ),
        border: border(),
        enabledBorder: border(),
        focusedBorder: border(),
      ),
    );
  }

  border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.r),
      borderSide: const BorderSide(color: AppColor.borderField),
    );
  }
}
