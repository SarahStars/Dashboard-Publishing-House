// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class JobsController extends GetxController {
//   var isLoading = false.obs;
//   var jobs = <Map<String, dynamic>>[].obs;

//   String token =
//       "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJwdWJsaXNoZXJfc2RmZ2hAc2RmZ2guZmdoaiIsImV4cCI6MTc1NzE5MjU2M30.5qCr7s4O8C6QoO2zOrUdICxm7t1G_7Hxy-cFFTmxwZQ";

//   // جلب جميع الفرص الخاصة بالناشر الحالي
//   Future<void> fetchMyVacancies() async {
//     isLoading.value = true;
//     try {
//       final url = Uri.parse(
//           "https://project2copyrepo-18.onrender.com/publisher/vacancies/my-vacancies");
//       final response = await http.get(
//         url,
//         headers: {
//           "accept": "application/json",
//           "Authorization": "Bearer $token",
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         // نتأكد من أن البيانات مصفوفة
//         if (data is List) {
//           jobs.value = List<Map<String, dynamic>>.from(data);
//         }
//       } else {
//         print("❌ فشل جلب البيانات: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("⚠️ حدث خطأ: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
