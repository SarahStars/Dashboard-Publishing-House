import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PublisherController extends GetxController {
  var isLoading = false.obs;
  var books = [].obs;
  var publisherName = "".obs;
  var totalBooks = 0.obs;

  /// جلب أحدث الكتب من أي دار نشر
  Future<void> fetchLatestBooks(int publisherId, {int limit = 10}) async {
    try {
      isLoading.value = true;

      final url =
          "https://project2copyrepo-12.onrender.com/publisher/$publisherId/latest-books?limit=$limit";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        publisherName.value = data["publisher_house"]["name"];
        totalBooks.value = data["total_books"];
        books.value = data["latest_books"]; // لائحة الكتب
      } else {
        Get.snackbar("Error", "Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
