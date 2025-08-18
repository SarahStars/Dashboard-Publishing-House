// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/reset_password_controller.dart';

// class ResetPasswordPage extends StatelessWidget {
//   const ResetPasswordPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(ResetPasswordController());

//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FB),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           "إعادة تعيين كلمة المرور",
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.black),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 40),
//             TextField(
//               controller: controller.passwordController,
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: "كلمة المرور الجديدة",
//                 prefixIcon: const Icon(Icons.lock_outline),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 fillColor: const Color(0xFFF1F1F1),
//                 filled: true,
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: controller.confirmPasswordController,
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: "تأكيد كلمة المرور الجديدة",
//                 prefixIcon: const Icon(Icons.lock),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 fillColor: Colors.white,
//                 filled: true,
//               ),
//             ),
//             const SizedBox(height: 30),
//             SizedBox(
//               width: double.infinity,
//               height: 72,
//               child: ElevatedButton(
//                 onPressed: controller.resetPassword,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF1D2A45),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   "حفظ كلمة المرور",
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
