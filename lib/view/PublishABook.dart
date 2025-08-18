import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:publishing_house/view/PublishedBooksPage.dart';
import 'package:publishing_house/view/home_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class PublishABook extends StatefulWidget {
  const PublishABook({super.key});

  @override
  State<PublishABook> createState() => _PublishABookState();
}

class _PublishABookState extends State<PublishABook> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _authorController = TextEditingController();
  final _priceController = TextEditingController();

  bool isFree = true;
  List<int> selectedCategories = [];
  File? bookFile;
  File? coverImage;

  final List<Map<String, dynamic>> categories = [
    {"id": 1, "name": "رواية"},
    {"id": 2, "name": "تاريخ"},
    {"id": 3, "name": "علوم"},
  ];

  Future<void> pickBookFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null && result.files.single.path != null) {
      setState(() {
        bookFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> pickCoverImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      setState(() {
        coverImage = File(result.files.single.path!);
      });
    }
  }

  Future<void> uploadBook() async {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty || _authorController.text.isEmpty || bookFile == null) {
      Get.snackbar("خطأ", "الرجاء إدخال كل الحقول المطلوبة");
      return;
    }

    var uri = Uri.parse("https://project2copyrepo-7.onrender.com/books/publisher/books/create");
 // ضع رابط API هنا
    var request = http.MultipartRequest('POST', uri);

    request.fields['title'] = _titleController.text;
    request.fields['description'] = _descriptionController.text;
    request.fields['is_free'] = isFree ? '1' : '0';
    if (!isFree) {
      request.fields['price'] = _priceController.text;
    }
    request.fields['author_name'] = _authorController.text;
    request.fields['category_ids'] = selectedCategories.join(",");

    request.files.add(await http.MultipartFile.fromPath('book_file', bookFile!.path));
    if (coverImage != null) {
      request.files.add(await http.MultipartFile.fromPath('cover_image', coverImage!.path));
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      Get.snackbar("تم", "تم نشر الكتاب بنجاح");
    } else {
      Get.snackbar("خطأ", "فشل نشر الكتاب");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Row(
        children: [
          // المحتوى الرئيسي
          Expanded(
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

                // نموذج نشر الكتاب
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
                            'نشر كتاب',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _titleController,
                            decoration: const InputDecoration(labelText: 'عنوان الكتاب'),
                          ),
                          TextField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(labelText: 'وصف الكتاب'),
                            maxLines: 3,
                          ),
                          TextField(
                            controller: _authorController,
                            decoration: const InputDecoration(labelText: 'اسم المؤلف'),
                          ),
                          SwitchListTile(
                            title: const Text('مجاني'),
                            value: isFree,
                            onChanged: (val) {
                              setState(() {
                                isFree = val;
                              });
                            },
                          ),
                          if (!isFree)
                            TextField(
                              controller: _priceController,
                              decoration: const InputDecoration(labelText: 'السعر'),
                              keyboardType: TextInputType.number,
                            ),
                          const SizedBox(height: 10),
                          const Text("التصنيفات:"),
                          Wrap(
                            spacing: 8,
                            children: categories.map((cat) {
                              final isSelected = selectedCategories.contains(cat['id']);
                              return ChoiceChip(
                                label: Text(cat['name']),
                                selected: isSelected,
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      selectedCategories.add(cat['id']);
                                    } else {
                                      selectedCategories.remove(cat['id']);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: pickBookFile,
                            icon: const Icon(Icons.picture_as_pdf),
                            label: Text(bookFile == null ? 'اختيار ملف PDF' : 'تم اختيار الملف'),
                          ),
                          ElevatedButton.icon(
                            onPressed: pickCoverImage,
                            icon: const Icon(Icons.image),
                            label: Text(coverImage == null ? 'اختيار صورة الغلاف' : 'تم اختيار الصورة'),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: uploadBook,
                            child: const Text("نشر الكتاب"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // القائمة الجانبية
          Container(
            width: 240,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset('images/Frame.png', height: 50),
                const SizedBox(height: 10),
                const Text(
                  'فكر',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 40),
                _buildMenuItem(Icons.home, 'الرئيسية', onTap: () {
                  Get.off(const HomePage());
                }),
                _buildMenuItem(Icons.menu_book, 'الكتب المنشورة', onTap: () {
                  Get.to(const PublishedBooksPage());
                }),
                _buildMenuItem(Icons.upload, 'نشر كتاب', onTap: () {
                  Get.to(const PublishABook());
                }),
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
