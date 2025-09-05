import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddJobController extends GetxController {
  var isLoading = false.obs;

  TextEditingController positionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController requirementsController = TextEditingController();

  // ضع هنا التوكن الخاص بالناشر
  String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJwdWJsaXNoZXJfc2RmZ2hAc2RmZ2guZmdoaiIsImV4cCI6MTc1NzE5MjU2M30.5qCr7s4O8C6QoO2zOrUdICxm7t1G_7Hxy-cFFTmxwZQ";

  Future<void> addJob() async {
    if (positionController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        requirementsController.text.isEmpty) {
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

      final response = await http.post(
        url,
        headers: {
          "accept": "application/json",
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        Get.snackbar("نجاح", "تم نشر الوظيفة بنجاح");
        Get.back(); // العودة لصفحة الوظائف
      } else {
        Get.snackbar("خطأ", "فشل النشر: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("خطأ", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

class AddJobPage extends StatelessWidget {
  AddJobPage({super.key});

  final controller = Get.put(AddJobController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: Row(
        textDirection: TextDirection.rtl,
        children: [
          // القائمة الجانبية
          Container(
            width: 240,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset('images/Frame.png', height: 50),
                const SizedBox(height: 40),
                _buildMenuItem(Icons.home, 'الرئيسية'),
                _buildMenuItem(Icons.upload, 'نشر كتاب'),
                _buildMenuItem(Icons.work_outline, 'فرص العمل'),
                _buildMenuItem(Icons.assignment, 'طلبات التوظيف'),
                _buildMenuItem(Icons.person, 'الملف الشخصي'),
                _buildMenuItem(Icons.settings, 'الإعدادات'),
                const Spacer(),
                _buildMenuItem(Icons.logout, 'تسجيل الخروج'),
              ],
            ),
          ),

          // المحتوى الرئيسي
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // الشريط العلوي (بحث + لوجو + تنبيهات)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // يسار (لوجو + تنبيهات)
                      Row(
                        children: [
                          Image.asset('images/Frame.png', height: 40),
                          const SizedBox(width: 16),
                          const Icon(Icons.notifications_none, color: Colors.black),
                        ],
                      ),

                      // يمين (بحث)
                      SizedBox(
                        width: 300,
                        child: TextField(
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: '...بحث',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: const Icon(Icons.search),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // المضمون (نموذج إضافة فرصة عمل)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          )
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // العنوان + السهم
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  "إضافة فرصة عمل",
                                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  icon: const Icon(Icons.arrow_forward, color: Colors.black),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // الحقول
                            _buildTextField("المنصب الوظيفي", controller.positionController),
                            const SizedBox(height: 16),
                            _buildTextField("الوصف", controller.descriptionController, maxLines: 3),
                            const SizedBox(height: 16),
                            _buildTextField("المتطلبات", controller.requirementsController, maxLines: 3),
                            const SizedBox(height: 24),

                            // زر النشر
                            Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: SizedBox(
                                width: 550,
                                child: Obx(
                                  () => ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF7A1C1C),
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  onPressed: () {
  print("زر النشر تم الضغط عليه");
  controller.addJob();
},


                                    child: controller.isLoading.value
                                        ? const SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : const Text(
                                            "نشر الفرصة",
                                            style: TextStyle(color: Colors.white, fontSize: 16),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // دالة بناء القائمة الجانبية
  Widget _buildMenuItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.black87)),
        ],
      ),
    );
  }

  // دالة لبناء الحقول النصية
  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: SizedBox(
        width: 550,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 6),
            TextField(
              controller: controller,
              maxLines: maxLines,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
