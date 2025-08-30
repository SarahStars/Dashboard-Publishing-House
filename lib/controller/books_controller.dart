import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:publishing_house/model/book_model.dart';

class BooksController extends GetxController {
  var isLoading = false.obs;
  var books = <Book>[].obs;
  var publisherName = ''.obs;

  File? bookFile;
  File? coverImage;

  /// جلب آخر الكتب
  Future<void> fetchLatestBooks({required int publisherId, int limit = 10}) async {
    isLoading.value = true;
    try {
      final url = Uri.parse(
          "https://project2copyrepo-12.onrender.com/publisher/$publisherId/latest-books?limit=$limit");

      final response = await http.get(url, headers: {"accept": "application/json"});

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        publisherName.value = data["publisher_house"]["name"];

        books.value = (data["latest_books"] as List)
            .map((book) => Book.fromJson(book))
            .toList();
      } else {
        Get.snackbar("خطأ", "فشل في جلب البيانات من السيرفر");
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدثت مشكلة: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// اختيار ملف الكتاب (PDF)
  Future<void> pickBookFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      bookFile = File(result.files.single.path!);
      Get.snackbar("تم", "تم اختيار ملف الكتاب");
    }
  }

  /// اختيار صورة الغلاف
  Future<void> pickCoverImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      coverImage = File(result.files.single.path!);
      Get.snackbar("تم", "تم اختيار صورة الغلاف");
    }
  }

  /// نشر كتاب جديد
  Future<void> publishBook({
    required String title,
    required String description,
    required String authorName,
    required bool isFree,
    String? price,
    required String categoryIds,
  }) async {
    if (bookFile == null) {
      Get.snackbar("تنبيه", "يرجى اختيار ملف الكتاب");
      return;
    }

    isLoading.value = true;
    try {
      final url = Uri.parse("https://project2copyrepo-12.onrender.com/books");

      var request = http.MultipartRequest("POST", url);

      request.fields['title'] = title;
      request.fields['description'] = description;
      request.fields['author_name'] = authorName;
      request.fields['is_free'] = isFree.toString();
      if (!isFree && price != null && price.isNotEmpty) {
        request.fields['price'] = price;
      }
      request.fields['category_ids'] = categoryIds;

      request.files.add(await http.MultipartFile.fromPath(
        'book_file',
        bookFile!.path,
      ));

      if (coverImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'cover_image',
          coverImage!.path, 
        ));
      }

      var response = await request.send();

      if (response.statusCode == 201) {
        Get.snackbar("نجاح", "تم نشر الكتاب بنجاح");
      } else {
        Get.snackbar("خطأ", "فشل في نشر الكتاب: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("خطأ", "حدثت مشكلة: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
