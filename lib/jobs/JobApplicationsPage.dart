import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:publishing_house/jobs/JobsPage.dart';
import 'package:publishing_house/book/My_books.dart';
import 'package:publishing_house/book/PublishBookPage.dart';
import 'package:publishing_house/book/PublishedBooksPage.dart';
import 'package:publishing_house/home/home_page.dart';

class JobApplicationsPage extends StatelessWidget {
  const JobApplicationsPage({super.key});

  // مثال بيانات، استبدليها بالبيانات الحقيقية من الـ API
  List<Map<String, String>> get sampleApplications => [
        {
          "name": "تسبيحة",
          "position": "مدقق لغوي",
          "coverLetter":
              "يسعدني التقدم لشغل فرصة \"مدقق لغوي\". لدي خبرة جيدة في مراجعة النصوص والتدقيق الإملائي والنحوي.",
          "cv": "MyCV.pdf",
          "date": "19-8-2025",
        },
        {
          "name": "أحمد علي",
          "position": "محرر محتوى",
          "coverLetter":
              "لدي خبرة تحريرية 4 سنوات وأتطلع للانضمام لفريقكم لأرتقي بمحتوى الكتب.",
          "cv": "CV_Ahmed.pdf",
          "date": "18-8-2025",
        },
        {
          "name": "سمية بدر",
          "position": "مراجعة لغوية",
          "coverLetter":
              "أنا متخصصة في التحرير اللغوي والتدقيق، وعملت مع دور نشر محلية.",
          "cv": "Sumaya_CV.pdf",
          "date": "15-8-2025",
        },
      ];

  @override
  Widget build(BuildContext context) {
    // نجعل محتوى الصفحة اتجاهه RTL حتى تظهر الأعمدة من اليمين لليسار
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FB),
        body: Row(
          children: [
            // ---------- القائمة الجانبية (يمين الشاشة) ----------
            Container(
              width: 220,
              height: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // اللوجو
                  Center(
                    child: Image.asset('images/Frame.png', height: 60),
                  ),
                  const SizedBox(height: 40),

                  // عناصر القائمة
                _buildMenuItem(Icons.home, 'الرئيسية',onTap: () {Get.to(() => const HomePage());},),
                _buildMenuItem(Icons.menu_book, 'الكتب المنشورة', onTap: () {Get.to(() => const PublishedBooksPage());}),
                _buildMenuItem(Icons.upload, 'نشر كتاب', onTap: () {Get.to(() => const PublishBookPage());}),
                _buildMenuItem(Icons.work_outline, 'فرص العمل',onTap: () {Get.to(() =>  JobsPage());}),
                _buildMenuItem(Icons.book, 'الكتب الخاصة بي ',onTap: () { Get.to(() => My_books()); }),
                _buildMenuItem(Icons.assignment, 'طلبات التوظيف',onTap: () {Get.to(() => JobApplicationsPage());}),
                _buildMenuItem(Icons.person, 'الملف الشخصي'),
                _buildMenuItem(Icons.settings, 'الإعدادات'),
                _buildMenuItem(Icons.notifications, 'الإشعارات'),
                const Spacer(),
                _buildMenuItem(Icons.logout,'تسجيل الخروج',),

                ],
              ),
            ),

            // ---------- المحتوى الرئيسي (إلى يسار القائمة) ----------
            Expanded(
              child: Column(
                children: [
                  // شريط علوي: شعار + إشعارات + بحث
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 20, 8, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // يسار الشريط: شعار + إشعارات
                        Row(
                          children: [
                            Image.asset('images/Frame.png', height: 40),
                            const SizedBox(width: 16),
                            const Icon(Icons.notifications_none,
                                color: Colors.black),
                          ],
                        ),
                        // يمين الشريط: صندوق البحث (نص محاذي لليمين)
                        SizedBox(
                          width: 300,
                          child: TextField(
                            textDirection: TextDirection.rtl,
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

                  // عنوان الصفحة
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'طلبات التوظيف',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),

                  // البطاقة التي تحتوي على الجدول
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 32, left: 12, bottom: 24),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 6)
                          ],
                        ),
                        child: Column(
                          children: [
                            // رأس الجدول
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              height: 56,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF4F4E8),
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                        child: Text('اسم المستخدم',
                                            textDirection:
                                                TextDirection.rtl)),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                        child: Text('المنصب الوظيفي',
                                            textDirection:
                                                TextDirection.rtl)),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Center(
                                        child: Text('خطاب التقديم',
                                            textDirection:
                                                TextDirection.rtl)),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                        child: Text('السيرة الذاتية',
                                            textDirection:
                                                TextDirection.rtl)),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                        child: Text('تاريخ التقديم',
                                            textDirection:
                                                TextDirection.rtl)),
                                  ),
                                  SizedBox(width: 56),
                                ],
                              ),
                            ),

                            // الصفوف
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(12)),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ...sampleApplications.map((app) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 14),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        app['name'] ?? '',
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        app['position'] ?? '',
                                                        textAlign:
                                                            TextAlign.right,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Align(
                                                      alignment: Alignment
                                                          .centerRight,
                                                      child: Text(
                                                        app['coverLetter'] ??
                                                            '',
                                                        textAlign:
                                                            TextAlign.right,
                                                        maxLines: 4,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        app['cv'] ?? '',
                                                        textAlign:
                                                            TextAlign.right,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        app['date'] ?? '',
                                                        textAlign:
                                                            TextAlign.right,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 56,
                                                    child: Center(
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (_) =>
                                                                AlertDialog(
                                                              title: const Text(
                                                                  'تفاصيل الطلب'),
                                                              content: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      'الاسم: ${app['name']}'),
                                                                  Text(
                                                                      'المنصب: ${app['position']}'),
                                                                  const SizedBox(
                                                                      height:
                                                                          8),
                                                                  Text(
                                                                      'خطاب التقديم:\n${app['coverLetter']}'),
                                                                  const SizedBox(
                                                                      height:
                                                                          8),
                                                                  Text(
                                                                      'السيرة: ${app['cv']}'),
                                                                  Text(
                                                                      'التاريخ: ${app['date']}'),
                                                                ],
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context),
                                                                  child: const Text(
                                                                      'إغلاق'),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.06),
                                                                blurRadius: 4,
                                                                offset:
                                                                    const Offset(
                                                                        0, 2),
                                                              )
                                                            ],
                                                          ),
                                                          child: const Icon(
                                                              Icons
                                                                  .remove_red_eye,
                                                              color: Color(
                                                                  0xFFB68E2F)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Divider(
                                                height: 1,
                                                color: Color(0xFFE9E9E9)),
                                          ],
                                        );
                                      }).toList(),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                ),
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
