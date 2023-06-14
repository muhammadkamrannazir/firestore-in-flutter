import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore/controllers/auth_controller.dart';
import 'package:firestore/utils/colors.dart';
import 'package:firestore/view/screens/group_chat.dart';
import 'package:firestore/view/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controllers/image_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then(
    (value) {
      Get.put(AuthController());
      Get.put(ImagePickerController());
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firestore Practice',
        theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: AppColor.scaffoldBackgroundColor),
        // home:  AzharNazir(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (c, userSnapshot) {
            if (userSnapshot.hasData) {
              return const GroupChatScreen();
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
