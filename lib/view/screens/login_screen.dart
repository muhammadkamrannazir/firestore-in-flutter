import 'package:firestore/controllers/auth_controller.dart';
import 'package:firestore/utils/colors.dart';
import 'package:firestore/view/screens/register_screen.dart';
import 'package:firestore/widgets/Custom_Button.dart';
import 'package:firestore/widgets/custom_text.dart';
import 'package:firestore/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passController = TextEditingController();
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                'Login',
                () {
                  AuthController.to.loginUser(
                    emailController.text.trim(),
                    passController.text.trim(),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    "Don't have an Account?",
                    fontSize: 20.sp,
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Get.to(const RegisterScreen());
                    },
                    child: CustomText(
                      'Register',
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
