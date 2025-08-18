import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http; // تم التعليق لأنه مؤقتًا لن نربط بالسيرفر

class VerifyOtpController extends GetxController {
  final codeLength = 6;
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    controllers = List.generate(codeLength, (_) => TextEditingController());
    focusNodes = List.generate(codeLength, (_) => FocusNode());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNodes[0].requestFocus();
    });
  }

  @override
  void onClose() {
    for (var c in controllers) c.dispose();
    for (var f in focusNodes) f.dispose();
    super.onClose();
  }

  Future<void> submitCode() async {
    final code = controllers.map((c) => c.text).join();
    if (code.length != codeLength) {
      Get.snackbar("تنبيه", "يرجى إدخال الرمز كاملاً");
      return;
    }

    isLoading.value = true;
    try {
      // ❌ الربط مع السيرفر معلق مؤقتًا
      /*
      final response = await http.post(
        Uri.parse("https://project2copyrepo-7.onrender.com/verify-otp"),
        headers: {"Content-Type": "application/json"},
        body: '{"otp":"$code"}',
      );

      if (response.statusCode == 200) {
        Get.toNamed('/request-sent');
      } else if (response.statusCode == 422) {
        Get.snackbar("خطأ", "رمز التحقق غير صالح أو منتهي الصلاحية");
      } else {
        Get.snackbar("خطأ", "حدثت مشكلة في التحقق من الرمز");
      }
      */

      // ✅ الانتقال مباشرة إلى واجهة تسجيل الدخول
      Get.offAllNamed('/request-sent');


    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ غير متوقع");
    } finally {
      isLoading.value = false;
    }
  }
}
