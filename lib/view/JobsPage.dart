import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:publishing_house/view/home_page.dart';

class JobsPage extends StatelessWidget {
  JobsPage({super.key});

  final List<Map<String, String>> jobs = [
    {
      "title": "مدرّرة محتوى أدبي",
      "description":
          "تبحث دار النشر عن مدررة محتوى أدبي لمراجعة النصوص، التدقيق اللغوي، وتحسين جودة المحتوى قبل نشره.",
      "requirements":
          "خبرة سابقة في التحرير أو التدقيق اللغوي، إتقان قواعد اللغة العربية، القدرة على العمل ضمن فريق، اهتمام بالأدب والثقافة.",
      "date": "19-8-2025"
    },
    {
      "title": "مدرّرة محتوى أدبي",
      "description":
          "تبحث دار النشر عن مدررة محتوى أدبي لمراجعة النصوص، التدقيق اللغوي، وتحسين جودة المحتوى قبل نشره. هذا النص طويل لتوضيح التمدد التلقائي للنص داخل الجدول.",
      "requirements":
          "خبرة سابقة في التحرير أو التدقيق اللغوي، إتقان قواعد اللغة العربية، القدرة على العمل ضمن فريق، اهتمام بالأدب والثقافة. هذه الجملة طويلة لاختبار التمدد.",
      "date": "19-8-2025"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: Row(
        textDirection: TextDirection.rtl, // القائمة على اليمين
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
                onTap: () {
                  Get.to(() => const HomePage());
                }
                ),
                _buildMenuItem(Icons.menu_book, 'الكتب المنشورة'),
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
              children: [
                // شريط البحث والإشعارات
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('images/Frame.png', height: 40),
                          const SizedBox(width: 16),
                          const Icon(Icons.notifications_none, color: Colors.black),
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

                // الجدول
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Container(
                      padding: const EdgeInsets.all(20),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // الصف العلوي: العنوان وإضافة فرصة
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // إضافة فرصة عمل
                                },
                                child: const Text(
                                  'إضافة فرصة عمل',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Text(
                                'فرص العمل الخاصة بي',
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // رأس الجدول
                          Container(
                            color: const Color(0xFFFFF8E1),
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              children: const [
                                Expanded(flex: 2, child: Text("عنوان الفرصة", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                                Expanded(flex: 3, child: Text("الوصف", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                                Expanded(flex: 3, child: Text("المتطلبات", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                                Expanded(flex: 1, child: Text("تاريخ النشر", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                                Expanded(flex: 1, child: Text("حذف", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold))),
                              ],
                            ),
                          ),

                          const SizedBox(height: 8),

                          // البيانات
                          Expanded(
                            child: ListView.builder(
                              itemCount: jobs.length,
                              itemBuilder: (context, index) {
                                final job = jobs[index];
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    textDirection: TextDirection.rtl,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(flex: 2, child: Text(job["title"]!, textAlign: TextAlign.right)),
                                      Expanded(flex: 3, child: Text(job["description"]!, textAlign: TextAlign.right, softWrap: true)),
                                      Expanded(flex: 3, child: Text(job["requirements"]!, textAlign: TextAlign.right, softWrap: true)),
                                      Expanded(flex: 1, child: Text(job["date"]!, textAlign: TextAlign.right)),
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          icon: const Icon(Icons.delete, color: Colors.red),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
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
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Icon(icon, size: 20, color: Colors.black54),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(fontSize: 14, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
