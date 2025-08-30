import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:publishing_house/view/JobsPage.dart';
import 'package:publishing_house/view/My_books.dart';
import 'package:publishing_house/view/home_page.dart';
import 'package:publishing_house/view/forgot_password.dart';
import 'package:publishing_house/view/PublishBookPage.dart';
import 'package:publishing_house/view/register_binding.dart';
import 'package:publishing_house/view/login_binding.dart';
import 'package:publishing_house/view/reset_password_page.dart';
import 'package:publishing_house/view/register_screen.dart';
import 'package:publishing_house/view/verify_code_screen.dart';
import 'package:publishing_house/view/request_sent_screen.dart';
import 'package:publishing_house/view/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:publishing_house/view/verify_code_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  // String? token = prefs.getString('access_token');

  // runApp(MyApp(isLoggedIn: token != null && token.isNotEmpty));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // key: UniqueKey(),
      title: 'Publishing House',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F9FB),
        fontFamily: 'Cairo',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/request-sent', page: () => const RequestSentScreen()),
        GetPage(name: '/register', page: () => const RegisterScreen(),binding: RegisterBinding(),),
        GetPage(name: '/login',page: () => const LoginView(),binding: LoginBinding(), ),
        GetPage(name: '/forgot-password',page: () => const ForgotPasswordScreen(), ),
        GetPage(name: '/verify-code', page: () => const VerifyCodeScreen(), binding: VerifyCodeBinding()),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/lates', page: () => const PublishBookPage()),
        GetPage(name: '/jobs', page: () =>  JobsPage()),
        GetPage(name: '/my_books', page: () => const  My_books()),


      ],
    );
  }
}
