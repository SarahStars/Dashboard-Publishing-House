import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:publishing_house/jobs/AddJobPage.dart';
import 'package:publishing_house/jobs/JobApplicationsPage.dart';
import 'package:publishing_house/book/My_books.dart';
import 'package:publishing_house/book/PublishBookPage.dart';
import 'package:publishing_house/book/PublishedBooksPage.dart';
import 'package:publishing_house/home/home_page.dart';

// ---------------------- Controller ----------------------
class JobsController extends GetxController {
  var isLoading = false.obs;
  var jobs = <Map<String, dynamic>>[].obs;

  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJwdWJsaXNoZXJfc2RmZ2hAc2RmZ2guZmdoaiIsImV4cCI6MTc1NzE5MjU2M30.5qCr7s4O8C6QoO2zOrUdICxm7t1G_7Hxy-cFFTmxwZQ";

  Future<void> fetchMyVacancies() async {
    isLoading.value = true;
    try {
      final url = Uri.parse(
          "https://project2copyrepo-18.onrender.com/publisher/vacancies/my-vacancies");
      final response = await http.get(
        url,
        headers: {
          "accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) {
          jobs.value = List<Map<String, dynamic>>.from(data);
        }
      } else {
        print("❌ فشل جلب البيانات: ${response.statusCode}");
      }
    } catch (e) {
      print("⚠️ حدث خطأ: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

// ---------------------- JobsPage ----------------------
class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  bool _hoveringAddJob = false;

  // ✅ تهيئة controller مباشرة
  final JobsController controller = Get.put(JobsController());

  @override
  void initState() {
    super.initState();
    controller.fetchMyVacancies();
  }

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
                _buildMenuItem(Icons.home, 'الرئيسية',
                    onTap: () => Get.to(() => const HomePage())),
                _buildMenuItem(Icons.menu_book, 'الكتب المنشورة',
                    onTap: () => Get.to(() => const PublishedBooksPage())),
                _buildMenuItem(Icons.upload, 'نشر كتاب',
                    onTap: () => Get.to(() => const PublishBookPage())),
                _buildMenuItem(Icons.work_outline, 'فرص العمل',
                    onTap: () => Get.to(() => const JobsPage())),
                _buildMenuItem(Icons.book, 'الكتب الخاصة بي',
                    onTap: () => Get.to(() => My_books())),
                _buildMenuItem(Icons.assignment, 'طلبات التوظيف',
                    onTap: () => Get.to(() => JobApplicationsPage())),
                _buildMenuItem(Icons.person, 'الملف الشخصي'),
                _buildMenuItem(Icons.settings, 'الإعدادات'),
                _buildMenuItem(Icons.notifications, 'الإشعارات'),
                const Spacer(),
                _buildMenuItem(Icons.logout, 'تسجيل الخروج'),
              ],
            ),
          ),

          // المحتوى الرئيسي
          Expanded(
            child: Column(
              children: [
                // شريط البحث والإشعارات
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('images/Frame.png', height: 40),
                          const SizedBox(width: 16),
                          const Icon(Icons.notifications_none,
                              color: Colors.black),
                        ],
                      ),
                      SizedBox(
                        width: 300,
                        child: TextField(
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: '...بحث',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
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

                // الجدول
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // الصف العلوي: العنوان وإضافة فرصة
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                onEnter: (_) {
                                  setState(() {
                                    _hoveringAddJob = true;
                                  });
                                },
                                onExit: (_) {
                                  setState(() {
                                    _hoveringAddJob = false;
                                  });
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => AddJobPage());
                                  },
                                  child: AnimatedDefaultTextStyle(
                                    duration:
                                        const Duration(milliseconds: 200),
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: _hoveringAddJob ? 18 : 16,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    child: const Text('إضافة فرصة عمل'),
                                  ),
                                ),
                              ),
                              const Text(
                                'فرص العمل الخاصة بي',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // رأس الجدول
                          Container(
                            color: const Color(0xFFFFF8E1),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              children: const [
                                Expanded(
                                    flex: 2,
                                    child: Text("عنوان الفرصة",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                Expanded(
                                    flex: 3,
                                    child: Text("الوصف",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                Expanded(
                                    flex: 3,
                                    child: Text("المتطلبات",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                Expanded(
                                    flex: 1,
                                    child: Text("تاريخ النشر",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                Expanded(
                                    flex: 1,
                                    child: Text("حذف",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                              ],
                            ),
                          ),

                          const SizedBox(height: 8),

                          // البيانات
                          Expanded(
                            child: Obx(() {
                              if (controller.isLoading.value) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (controller.jobs.isEmpty) {
                                return const Center(
                                    child: Text("لا توجد فرص بعد"));
                              } else {
                                return ListView.builder(
                                  itemCount: controller.jobs.length,
                                  itemBuilder: (context, index) {
                                    final job = controller.jobs[index];
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        textDirection: TextDirection.rtl,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                  job["position"] ?? "")),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                  job["description"] ?? "",
                                                  softWrap: true)),
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                  job["requirements"] ?? "",
                                                  softWrap: true)),
                                          Expanded(
                                              flex: 1,
                                              child: Text(job["date"] ?? "")),
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  icon: const Icon(
                                                      Icons.remove_red_eye,
                                                      color: Colors.blue),
                                                  onPressed: () {},
                                                  tooltip: 'عرض',
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                      Icons.edit,
                                                      color: Colors.orange),
                                                  onPressed: () {},
                                                  tooltip: 'تعديل',
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red),
                                                  onPressed: () {},
                                                  tooltip: 'حذف',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            }),
                          ),
                        ],
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

  Widget _buildMenuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        textAlign: TextAlign.end,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
      onTap: onTap,
    );
  }
}
