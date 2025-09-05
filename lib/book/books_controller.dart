import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:publishing_house/constants/linkapi.dart'; // ✅ مهم لتعريف MediaType

class BooksController extends GetxController {
  var isLoading = false.obs;

  // ملفات الكتاب والغلاف للويب
  Uint8List? bookFileBytes;
  String? bookFileName;

  Uint8List? coverImageBytes;
  String? coverFileName;

  /// اختيار ملف الكتاب (PDF)
  Future<void> pickBookFile(Uint8List? bytes, String? name) async {
    if (bytes != null && name != null) {
      bookFileBytes = bytes;
      bookFileName = name;
      print("📄 تم اختيار ملف الكتاب: $name");
      Get.snackbar("تم", "تم اختيار ملف الكتاب");
    }
  }

  /// اختيار صورة الغلاف
  Future<void> pickCoverImage(Uint8List? bytes, String? name) async {
    if (bytes != null && name != null) {
      coverImageBytes = bytes;
      coverFileName = name;
      print("🖼️ تم اختيار صورة الغلاف: $name");
      Get.snackbar("تم", "تم اختيار صورة الغلاف");
    }
  }

  /// نشر الكتاب
  Future<void> publishBook({
    required String title,
    required String description,
    required String authorName,
    required bool isFree,
    String? price,
    required String categoryIds,
    required String authToken, // 🔑 تمرير التوكن
  }) async {
    print("🚀 بدء عملية نشر الكتاب...");

    if (bookFileBytes == null) {
      print("⚠️ لم يتم اختيار ملف الكتاب");
      Get.snackbar("تنبيه", "يرجى اختيار ملف الكتاب");
      return;
    }

    isLoading.value = true;

    try {
      final url = Uri.parse(linkPublishBook );
      print("🌐 رابط الطلب: $url");

      var request = http.MultipartRequest("POST", url);

      // ===== رؤوس الطلب =====
      request.headers['Authorization'] = 'Bearer $authToken';
      request.headers['accept'] = 'application/json';

      print("✏️ تم إنشاء MultipartRequest");

      // ===== حقول الطلب =====
      request.fields['title'] = title;
      request.fields['description'] = description;
      request.fields['author_name'] = authorName;
      request.fields['is_free'] = isFree.toString();
      if (!isFree && price != null && price.isNotEmpty) {
        request.fields['price'] = price;
      }
      else if (!isFree) {
  request.fields.remove('price'); // لا ترسل السعر إذا الكتاب مجاني
}
      request.fields['category_ids'] = categoryIds;

      // ===== إضافة ملفات =====
      print("📄 إضافة ملف الكتاب...");
      request.files.add(
        http.MultipartFile.fromBytes(
          'book_file',
          bookFileBytes!,
          filename: bookFileName!,
          contentType: MediaType('application', 'pdf'), // ✅ نوع الملف PDF
        ),
      );

      if (coverImageBytes != null) {
        print("🖼️ إضافة صورة الغلاف...");
        request.files.add(
          http.MultipartFile.fromBytes(
            'cover_image',
            coverImageBytes!,
            filename: coverFileName!,
            contentType: MediaType('image', 'jpeg'), // ✅ نوع الصورة JPEG
          ),
        );
      }

      print("⏳ إرسال الطلب إلى السيرفر...");
      var response = await request.send();
      print("📥 تم استلام الرد: ${response.statusCode}");

      if (response.statusCode == 201 || response.statusCode == 200 ) {
        print("✅ تم نشر الكتاب بنجاح");
        Get.snackbar("نجاح", "تم نشر الكتاب بنجاح");
      } else {
        print("❌ فشل نشر الكتاب، رمز الحالة: ${response.statusCode}");
        Get.snackbar(
          "خطأ",
          "فشل في نشر الكتاب: ${response.statusCode}",
        );
      }
    } catch (e) {
      print("💥 حدث خطأ أثناء النشر: $e");
      Get.snackbar("خطأ", "حدثت مشكلة: $e");
    } finally {
      isLoading.value = false;
      print("🔚 انتهاء عملية النشر");
    }
  }
}
