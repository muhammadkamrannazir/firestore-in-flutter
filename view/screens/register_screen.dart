import 'package:firestore/controllers/auth_controller.dart';
import 'package:firestore/utils/colors.dart';
import 'package:firestore/utils/images.dart';
import 'package:firestore/view/screens/login_screen.dart';
import 'package:firestore/widgets/Custom_Button.dart';
import 'package:firestore/widgets/custom_text.dart';
import 'package:firestore/widgets/custom_text_field.dart';
import 'package:firestore/widgets/pick_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passController = TextEditingController();
    final nameController = TextEditingController();
    final authController = Get.put(AuthController());

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => PickImageButton(
                  imageFile: authController.profilePhoto,
                  backgroundImage: authController.profilePhoto != null
                      ? FileImage(authController.profilePhoto!)
                          as ImageProvider<Object>
                      : AssetImage(AppAssets.profile),
                  onPressed: () {
                    authController.pickImage();
                  },
                ),
              ),
              SizedBox(height: 30.h),
              CustomTextFormField(
                controller: nameController,
                hintText: 'Username',
                prefixIcon: Icons.person,
              ),
              CustomTextFormField(
                controller: emailController,
                hintText: 'Email',
                prefixIcon: Icons.email,
              ),
              CustomTextFormField(
                controller: passController,
                hintText: 'Password',
                prefixIcon: Icons.lock,
              ),
              CustomButton(
                'Register',
                () {
                  if (AuthController.to.profilePhoto == null) {
                    Get.snackbar('Error', 'Please select an image');
                    return;
                  }

                  AuthController.to.registerUser(
                    nameController.text.trim(),
                    emailController.text.trim(),
                    passController.text.trim(),
                    AuthController.to.profilePhoto!,
                  ) ;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    "Already have an Account?",
                    fontSize: 20.sp,
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Get.to(const LoginScreen());
                    },
                    child: CustomText(
                      'Login',
                      color: AppColor.buttonColor!,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
