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

void bottomPopUpMessage(BuildContext context, String message,
    {bool showError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration:
      showError ? const Duration(seconds: 2) : const Duration(seconds: 1),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: showError ? Colors.red : Colors.green,
    ),
  );
}