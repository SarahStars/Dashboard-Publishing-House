import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AddJobController extends GetxController {
  var isLoading = false.obs;

  // Controllers للحقول
  TextEditingController positionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController requirementsController = TextEditingController();

  // توكن المستخدم (يمكنك تخزينه في SharedPreferences أو GetStorage)
  String token = "هنا ضع التوكن الخاص بالناشر";

Future<void> addJob() async {
  print("🚀 بدء عملية نشر الوظيفة...");

  if (positionController.text.isEmpty ||
      descriptionController.text.isEmpty ||
      requirementsController.text.isEmpty) {
    print("⚠️ بعض الحقول فارغة");
    Get.snackbar("خطأ", "الرجاء ملء جميع الحقول");
    return;
  }

  isLoading.value = true;
  try {
    final url = Uri.parse("https://project2copyrepo-18.onrender.com/publisher/vacancies/");
    final body = jsonEncode({
      "position": positionController.text,
      "description": descriptionController.text,
      "requirements": requirementsController.text,
    });

    print("📄 البيانات المرسلة:");
    print(body);

    print("🌐 إرسال الطلب إلى: $url");
    final response = await http.post(
      url,
      headers: {
        "accept": "application/json",
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: body,
    );

    print("📥 تم استلام الرد من السيرفر:");
    print("Status Code: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 200) {
      print("✅ تم نشر الوظيفة بنجاح");
      Get.snackbar("نجاح", "تم نشر الوظيفة بنجاح");
      Get.back(); // العودة لصفحة الوظائف
    } else {
      print("❌ فشل النشر");
      Get.snackbar("خطأ", "فشل النشر: ${response.statusCode}");
    }
  } catch (e) {
    print("⚠️ حدث خطأ أثناء الطلب:");
    print(e.toString());
    Get.snackbar("خطأ", e.toString());
  } finally {
    isLoading.value = false;
    print("⏹ انتهاء عملية النشر");
  }
}

}
