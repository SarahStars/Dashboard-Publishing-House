import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RequestSentScreen extends StatefulWidget {
  const RequestSentScreen({super.key});

  @override
  State<RequestSentScreen> createState() => _RequestSentScreenState();
}

class _RequestSentScreenState extends State<RequestSentScreen> {
  @override
  void initState() {
    super.initState();

    // مؤقت 2 ثانية ثم الانتقال باستخدام GetX
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed('/login');

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //  image: AssetImage('images/register_illustration.png'),✅ صورة التأكيد
              Image.asset(
                'images/Group.png', // تأكدي من المسار الصحيح
                width: 180,
                height: 180,
              ),
              const SizedBox(height: 40),

              // ✅ عنوان
              const Text(
                'تم إرسال طلبك إلى الأدمن',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1D2A45),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // ✅ وصف
              const Text(
                'سيتم مراجعة المعلومات من قبل الأدمن، ثم يمكنك تسجيل الدخول إلى الداشبورد والاستفادة من جميع الخاصيات',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 32),

              // ✅ دائرة تحميل + نص
              const CircularProgressIndicator(
                color: Color(0xFF1D2A45), // نفس لون العنوان
              ),
              const SizedBox(height: 16),
              const Text(
                'يرجى الانتظار...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
