import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:publishing_house/controller/books_controller.dart';
import 'package:publishing_house/view/home_page.dart';
import 'package:publishing_house/view/My_books.dart';

class PublishBookPage extends StatefulWidget {
  const PublishBookPage({super.key});

  @override
  State<PublishBookPage> createState() => _PublishBookPageState();
}

class _PublishBookPageState extends State<PublishBookPage> {
  final BooksController controller = Get.put(BooksController());

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoriesController = TextEditingController();

  bool _isFree = true;
  String? _bookFileName;
  String? _coverFileName;

  Future<void> _pickBookFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if (result != null) {
      if (kIsWeb) {
        controller.bookFile = null;
      } else {
        controller.bookFile = File(result.files.single.path!);
      }
      setState(() {
        _bookFileName = result.files.single.name;
      });
      Get.snackbar("تم", "تم اختيار ملف الكتاب");
    }
  }

  Future<void> _pickCoverImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      if (kIsWeb) {
        controller.coverImage = null;
      } else {
        controller.coverImage = File(result.files.single.path!);
      }
      setState(() {
        _coverFileName = result.files.single.name;
      });
      Get.snackbar("تم", "تم اختيار صورة الغلاف");
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFF8F9FB),
    body: Row(
      children: [
        // ----------- الجزء الأيسر: محتوى نشر الكتاب -----------
        Expanded(
          child: Directionality( // 👈 نخلي RTL هنا فقط
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                // الشريط العلوي
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
                          textDirection: TextDirection.rtl,
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

                // نموذج النشر
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListView(
                        children: [
                          const Text(
                            'نشر كتاب جديد',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _titleController,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(labelText: 'عنوان الكتاب *'),
                          ),
                          TextField(
                            controller: _descriptionController,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(labelText: 'وصف الكتاب *'),
                            maxLines: 3,
                          ),
                          TextField(
                            controller: _authorController,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(labelText: 'اسم المؤلف *'),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text('هل الكتاب مجاني؟'),
                              Switch(
                                value: _isFree,
                                onChanged: (val) {
                                  setState(() {
                                    _isFree = val;
                                  });
                                },
                              ),
                            ],
                          ),
                          if (!_isFree)
                            TextField(
                              controller: _priceController,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(labelText: 'السعر'),
                            ),
                          TextField(
                            controller: _categoriesController,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(
                              labelText: 'أرقام التصنيفات (مثال: 1,2,3) *',
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: _pickBookFile,
                            icon: const Icon(Icons.upload_file),
                            label: const Text("رفع ملف الكتاب (PDF) *"),
                          ),
                          if (_bookFileName != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'تم اختيار الملف: $_bookFileName',
                                style: const TextStyle(fontSize: 14, color: Colors.green),
                              ),
                            ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: _pickCoverImage,
                            icon: const Icon(Icons.image),
                            label: const Text("رفع صورة الغلاف (اختياري)"),
                          ),
                          if (_coverFileName != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'تم اختيار الصورة: $_coverFileName',
                                style: const TextStyle(fontSize: 14, color: Colors.green),
                              ),
                            ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1D2A45),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            onPressed: () {
                              controller.publishBook(
                                title: _titleController.text,
                                description: _descriptionController.text,
                                authorName: _authorController.text,
                                isFree: _isFree,
                                price: _priceController.text,
                                categoryIds: _categoriesController.text,
                              );
                            },
                            child: const Text(
                              'نشر الكتاب',
                              style: TextStyle(color: Colors.white, fontSize: 18),
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
        ),

        // ----------- الجزء الأيمن: القائمة الجانبية -----------
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
              _buildMenuItem(Icons.menu_book, 'كتبي',
                  onTap: () => Get.to(() => const My_books())),
              _buildMenuItem(Icons.upload, 'نشر كتاب'),
              _buildMenuItem(Icons.work_outline, 'فرص العمل'),
              _buildMenuItem(Icons.assignment, 'طلبات التوظيف'),
              _buildMenuItem(Icons.person, 'الملف الشخصي'),
              _buildMenuItem(Icons.settings, 'الإعدادات'),
              _buildMenuItem(Icons.notifications, 'الإشعارات'),
              const Spacer(),
              _buildMenuItem(Icons.logout, 'تسجيل الخروج'),
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
