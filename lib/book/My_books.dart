import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:publishing_house/jobs/JobApplicationsPage.dart';
import 'package:publishing_house/jobs/JobsPage.dart';
import 'package:publishing_house/book/PublishBookPage.dart';
import 'package:publishing_house/book/PublishedBooksPage.dart';
import 'package:publishing_house/home/home_page.dart';


class My_books extends StatelessWidget {
  const My_books({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'ديني',
      'تاريخي',
      'روايات',
      'تراثي',
      'أطفال',
      'علمي',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Row(
        children: [
          // الجانب الأيسر (المحتوى)
          Expanded(
            child: Column(
              children: [
                // الشريط العلوي
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // أيقونة الإشعارات واللوغو
                      Row(
                        children: [
                          Image.asset('images/Frame.png', height: 40),
                          const SizedBox(width: 16),
                          const Icon(
                            Icons.notifications_none,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      // حقل البحث
                      SizedBox(
                        width: 300,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '...بحث',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
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

                // عنوان التصنيفات
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      ' الكتب الخاصة بي  ' ,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // أزرار التصنيفات
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      itemCount: categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (_, index) {
                        return ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                index == 0 ? Colors.red[800] : Colors.grey[300],
                            foregroundColor:
                                index == 0 ? Colors.white : Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(categories[index]),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // شبكة الكتب
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 20,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.65,
                          ),
                      itemBuilder: (context, index) => _buildBookCard(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // القائمة الجانبية اليمنى
          Container(
            width: 240,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset('images/Frame.png', height: 50),
                const SizedBox(height: 40),
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

  Widget _buildBookCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset('images/Frame117.png', fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  'رجال حول الرسول',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  'خالد محمد خالد',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  'عدد الصفحات: 352',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
