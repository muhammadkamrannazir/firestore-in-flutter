import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? name;
  String? email;
  String? profilePhoto;
  String? uid;
  UserModel({
    this.name,
    this.email,
    this.profilePhoto,
    this.uid,
  });

  Map<String, dynamic> toJson() => {
        'username': name,
        'email': email,
        'profilePhoto': profilePhoto,
        'uid': uid,
      };

  static UserModel fromJson(snapshot) {
    // var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      name: snapshot['name'],
      email: snapshot['email'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
    );
  }

  // static Future<UserModel> getCurrentUser() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   var guestUser = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user!.uid)
  //       .collection('name')
  //       .get();
  //   return UserModel.fromJson(guestUser);
  // }
}
