import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:publishing_house/utils/validation.dart';
import 'package:publishing_house/constants/linkapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  // للتحكم بالنصوص
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // لإظهار / إخفاء كلمة المرور
  var showPassword = false.obs;

  // حالة التحميل (لـ اللودينغ)
  var isLoading = false.obs;

  // مفتاح النموذج
  late final GlobalKey<FormState> formKey;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  // ✅ التحقق من صحة الإيميل
  String? validateEmail(String? val) {
    return validInput(val!, 5, 50, type: 'email');
  }

  // ✅ التحقق من صحة كلمة المرور
  String? validatePassword(String? val) {
    return validInput(val!, 8, 100, type: 'password');
  }

  // ✅ تسجيل الدخول مع ربط بالباك
  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      showSnackbarError("يرجى التأكد من إدخال البريد وكلمة المرور بشكل صحيح");
      return;
    }

    isLoading.value = true;

    try {
      // القيم المرسلة
      final body = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };

      print("📤 البيانات المرسلة للسيرفر:");
      print(body);

      final response = await http.post(
        Uri.parse(linkLogin),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("id", data['id'].toString());

        Get.offAllNamed("/home");
        print("✅ تسجيل الدخول تم بنجاح");
      } else {
        final error =
            jsonDecode(response.body)['detail'] ??
            "الإيميل أو كلمة المرور غير صحيحة أو الحساب غير موجود.";
        showDialogError(error);
        print("❌ فشل تسجيل الدخول");
      }
    } catch (e) {
      showDialogError("حدث خطأ أثناء الاتصال بالخادم. يرجى المحاولة لاحقًا.");
      print("❌ Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ✅ نافذة حوار لعرض الخطأ
  void showDialogError(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text("تنبيه", style: TextStyle(color: Colors.redAccent)),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("موافق")),
        ],
      ),
      barrierDismissible: false,
    );
  }

  // ✅ Snackbar عند التحقق من الحقول
  void showSnackbarError(String message) {
    Get.snackbar(
      'خطأ في تسجيل الدخول',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.red.shade900,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
  }

  // ✅ الانتقال إلى صفحة إنشاء حساب
  void goToRegister() {
    Get.toNamed('/register');
  }

  // ✅ الانتقال إلى صفحة نسيت كلمة المرور
  void goToForgotPassword() {
    Get.toNamed('/forgot-password');
  }
}
