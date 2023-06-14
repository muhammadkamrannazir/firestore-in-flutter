import 'package:flutter/material.dart';
import 'package:get/get.dart';

showCircular() {
  Get.dialog(
    const CircularProgressIndicator(),
  );
}
