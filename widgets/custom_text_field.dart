import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function(String?)? onSaved;
  final Widget? icon;
  final bool? obscureText;
  final bool? visibility;
  final bool? dataFieldStyle;
  final bool readOnly;
  final Function? onShowPassword;
  final IconData? prefixIcon;

  final String? Function(String?)? validator;

  CustomTextFormField({
    Key? key,
    this.hintText,
    this.errorText,
    this.readOnly = false,
    this.keyboardType,
    this.textInputAction,
    this.onSaved,
    this.controller,
    this.icon,
    this.obscureText = false,
    this.visibility = false,
    this.dataFieldStyle = true,
    this.onShowPassword,
    this.validator,
    this.prefixIcon,
  }) : super(key: key);

  // final passController = Get.put(PassController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        TextFormField(
          readOnly: readOnly,
          controller: controller,
          obscureText: obscureText!,
          keyboardType: keyboardType,
          textInputAction: TextInputAction.done,
          onSaved: onSaved,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
              errorText: errorText,
              border: border(),
              // enabledBorder: border(),
              // focusedBorder: border(),
              contentPadding: EdgeInsets.symmetric(
                vertical: 16.h,
                horizontal: 10.w,
              ),
              hintText: hintText,
              prefixIcon: Icon(prefixIcon)
              // suffixIcon: visibility == true
              //     ? InkWell(
              //         child: icon,
              //         onTap: () {
              //           onShowPassword!();
              //         },
              //       )
              //     : null,
              // hintStyle: TextStyle(
              //   fontSize: 16.sp,
              //   fontWeight: FontWeight.w400,
              //   color: AppColor.white,
              // ),
              ),
          // style: TextStyle(
          //   fontSize: 16.sp,
          //   fontWeight: FontWeight.w400,
          //   color: AppColor.white,
          // ),
          validator: validator,
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  void dissmissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      // borderSide:  BorderSide(color: AppColor.black),
    );
  }
}
