import 'dart:io';

import 'package:firestore/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class PickImageButton extends StatelessWidget {
  final File? imageFile; // Add non-null assertion
  final ImageProvider<Object>? backgroundImage;
  final void Function()? onPressed;

  const PickImageButton({
     this.imageFile, // Make imageFile parameter required
    this.backgroundImage,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 64.r,
          backgroundColor: AppColor.blue,
          backgroundImage: backgroundImage,
          // child: imageFile != null // Add condition to show image only when imageFile is not null
          //     ? Image.file(
          //         imageFile!,
          //         height: 100.h,
          //         width: 100.w,
          //       )
          //     : null,
        ),
        Positioned(
          bottom: -10,
          left: 80.w,
          child: IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.add_a_photo),
          ),
        ),
      ],
    );
  }
}
