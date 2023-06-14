import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore/model/user.dart';
import 'package:firestore/view/screens/group_chat.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  late final Rx<File?> _pickedImage = Rx<File?>(null);

  File? get profilePhoto => _pickedImage.value;

  void pickImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (img != null) {
      Get.snackbar(
        'Image Picked',
        'Image Uploaded Successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      _pickedImage.value = File(img.path);
    }
  }

  Future<String> _uploadImageToStorage(File image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Get.off(const GroupChatScreen());
      } else {
        Get.snackbar('Error Logging In', 'Please enter all fields');
      }
    } catch (e) {
      Get.snackbar('Error logging in', e.toString());
    }
  }

  void registerUser(
      String name, String email, String password, File image) async {
    try {
      if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        // set the display name
        User? dname = cred.user;
        if (dname != null) {
          await dname.updateDisplayName(name);
          await dname.reload();
        }
        String downloadUrl = await _uploadImageToStorage(image);
        UserModel user = UserModel(
            name: name,
            email: email,
            profilePhoto: downloadUrl,
            uid: cred.user!.uid);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson())
            .then(
              (value) => Get.off(
                const GroupChatScreen(),
              ),
            );
      }
    } catch (e) {
      Get.snackbar(
        'Error creating account',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
