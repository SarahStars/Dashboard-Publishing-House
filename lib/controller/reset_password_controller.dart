import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void resetPassword() {
    final password = passwordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    if (password.isEmpty || confirm.isEmpty) {
      Get.snackbar("خطأ", "جميع الحقول مطلوبة");
      return;
    }

    if (password != confirm) {
      Get.snackbar("خطأ", "كلمتا المرور غير متطابقتين");
      return;
    }

    
    Get.snackbar("نجاح", "تم تحديث كلمة المرور بنجاح");
    Get.offAllNamed('/home');
  }
}
