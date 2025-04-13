import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBarMassage(String message, [bool isError = false]) {
  Get.showSnackbar(
    GetSnackBar(
      message: message,
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
    ),
  );
}
