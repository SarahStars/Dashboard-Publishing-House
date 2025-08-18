// import 'package:flutter/material.dart';

// class ForgotPasswordPage extends StatelessWidget {
//   const ForgotPasswordPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FB),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           "نسيت كلمة المرور",
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
//             const SizedBox(height: 60),
//             const Text(
//               "قم بإدخال البريد الالكتروني لإعادة\nتعيين كلمة المرور",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.black,
//                 height: 1.5,
//               ),
//             ),
//             const SizedBox(height: 30),

//             // TextField بعرض ثابت
//             Center(
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(maxWidth: 489),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     labelText: "البريد الإلكتروني",
//                     prefixIcon: const Icon(Icons.email_outlined),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     filled: true,
//                     fillColor: Colors.white,
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 30),

//             // زر الإرسال بعرض ثابت
//             Center(
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(maxWidth: 487),
//                 child: SizedBox(
//                   height: 72,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // منطق إرسال الرمز
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF1D2A45),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       elevation: 0,
//                     ),
//                     child: const Text(
//                       "إرسال رمز التحقق",
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 16),

//             // نص "إرسال الرمز مرة أخرى؟" بعرض ثابت ومتمركز
//             Center(
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(maxWidth: 487),
//                 child: const Text(
//                   "إرسال الرمز مرة أخرى؟",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Color(0xFF6B1B1B),
//                     fontSize: 14,
//                     decoration: TextDecoration.underline,
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
