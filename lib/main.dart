import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:publishing_house/view/home_page.dart';
import 'package:publishing_house/view/forgot_password.dart';
import 'package:publishing_house/view/login_binding.dart';
import 'package:publishing_house/view/reset_password_page.dart';
import 'package:publishing_house/view/register_screen.dart';
import 'package:publishing_house/view/verify_code_screen.dart';
import 'package:publishing_house/view/request_sent_screen.dart';
import 'package:publishing_house/view/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  // String? token = prefs.getString('access_token');

  // runApp(MyApp(isLoggedIn: token != null && token.isNotEmpty));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 // final bool isLoggedIn;
  const MyApp({super.key});
  // const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Publishing House',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F9FB),
        fontFamily: 'Cairo',
      ),
      debugShowCheckedModeBanner: false,
      // home: isLoggedIn ? const HomePage() : RegisterScreen(),
      home: RegisterScreen(),
      getPages: [
        GetPage(name: '/request-sent', page: () => RequestSentScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/login', page: () => const LoginView(), binding: LoginBinding()),
        GetPage(name: '/verify-code', page: () => const VerifyCodeScreen()),
        GetPage(name: '/home', page: () => const HomePage()),
      ],
    );
  }
}
/*void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access_token');

  runApp(MyApp(isLoggedIn: token != null && token.isNotEmpty));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Publishing House',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F9FB),
        fontFamily: 'Cairo',
      ),
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const HomePage() : RegisterScreen(),
      getPages: [
        GetPage(name: '/request-sent', page: () => RequestSentScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/login', page: () => const LoginView(), binding: LoginBinding()),
        GetPage(name: '/verify-code', page: () => const VerifyCodeScreen()),
        GetPage(name: '/home', page: () => const HomePage()),
      ],
    );
  }
}
 */