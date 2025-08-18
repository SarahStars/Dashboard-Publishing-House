import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:publishing_house/constants/linkapi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class RegisterController extends GetxController {
  late final GlobalKey<FormState> formKey;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final licenseController = TextEditingController();
  final logoController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var showPassword = false.obs;
  var showConfirmPassword = false.obs;
  var isLoading = false.obs;

  var logoImageBytes = Rx<Uint8List?>(null);
  var licenseImageBytes = Rx<Uint8List?>(null);

  var logoError = ''.obs;
  var licenseError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
  }

  void togglePasswordVisibility() => showPassword.toggle();
  void toggleConfirmPasswordVisibility() => showConfirmPassword.toggle();

  bool validateImages() {
    bool isValid = true;

    if (licenseImageBytes.value == null) {
      licenseError.value = 'لا يمكن إنشاء الحساب بدون الترخيص';
      isValid = false;
    } else {
      licenseError.value = '';
    }

    if (logoImageBytes.value == null) {
      logoError.value = 'لا يمكن إنشاء الحساب بدون الشعار';
      isValid = false;
    } else {
      logoError.value = '';
    }

    return isValid;
  }

  void register() async {
    final formValid = formKey.currentState?.validate() ?? false;
    final imagesValid = validateImages();

    if (!formValid || !imagesValid) return;
    isLoading.value = true;

    try {
      final uri = Uri.parse(linkSignUp);
      final request = http.MultipartRequest('POST', uri);

      request.fields['name'] = nameController.text.trim();
      request.fields['email'] = emailController.text.trim();
      request.fields['password'] = passwordController.text.trim();
      request.fields['confirm_password'] =
          confirmPasswordController.text.trim();

      request.files.add(
        http.MultipartFile.fromBytes(
          'license_image',
          licenseImageBytes.value!,
          filename: 'license.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      request.files.add(
        http.MultipartFile.fromBytes(
          'logo_image',
          logoImageBytes.value!,
          filename: 'logo.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      request.headers['Accept'] = 'application/json';

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      isLoading.value = false;

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        Get.snackbar("تم التسجيل", "تم إرسال الكود إلى بريدك");
        Get.toNamed('/verify-code');
      } else {
        final error = jsonDecode(response.body)['detail'] ?? 'فشل في التسجيل';
        Get.snackbar(
          "خطأ",
          error.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "خطأ",
        "حدث خطأ أثناء الاتصال",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    licenseController.dispose();
    logoController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
