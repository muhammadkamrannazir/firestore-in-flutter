// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore/model/user.dart';
import 'package:firestore/view/screens/login_screen.dart';
import 'package:firestore/widgets/custom_text.dart';
import 'package:firestore/widgets/message_typing_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({super.key});

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  String? messageText;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User? loggedInUser;
  UserModel userModel = UserModel();
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 48.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_outlined),
                  onPressed: () {
                    Get.back();
                  },
                ),
                CustomText(
                  'Group Chat',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
                IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Get.offAll(const LoginScreen());
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _firestore.collection('messages').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Text('No messages');
                  }
                  final messages = snapshot.data!.docs;
                  List<Text> messageWidgets = [];
                  for (var message in messages) {
                    final messageText = message.data()['text'];
                    final messageSender = message.data()['sender'];
                    final messageWidget = Text(
                      '$messageText from ${userModel.name}',
                    );
                    messageWidgets.add(messageWidget);
                  }
                  return ListView(
                    children: messageWidgets,
                  );
                },
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 5.w),
                    CustomText(
                      'Typing...',
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                MessageTypingField(
                    controller: typingFieldController,
                    onChanged: (value) {
                      setState(() {
                        typingFieldController.text = value;
                      });
                    },
                    send: () {
                      send();
                      typingFieldController.clear();
                    }),
                SizedBox(height: 15.h),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final typingFieldController = TextEditingController();
  void send() {
    _firestore.collection('messages').add({
      'text': typingFieldController.text.trim(),
      'sender': loggedInUser!.email,
    });
  }
}
