import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:publishing_house/controller/verify_otp_controller.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyOtpController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Obx(() {
          return AbsorbPointer(
            absorbing: controller.isLoading.value,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'أدخل رمز التحقق',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D2A45),
                    ),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'لقد أرسلنا رمزًا مكوّنًا من 6 أرقام إلى بريدك الإلكتروني / رقم هاتفك.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(controller.codeLength, (index) {
                      return Container(
                        width: 45,
                        height: 55,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F4FA),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: controller.controllers[index],
                          focusNode: controller.focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20),
                          maxLength: 1,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              if (index < controller.codeLength - 1) {
                                controller.focusNodes[index + 1].requestFocus();
                              } else {
                                FocusScope.of(context).unfocus();
                                controller.submitCode();
                              }
                            } else if (value.isEmpty && index > 0) {
                              controller.focusNodes[index - 1].requestFocus();
                            }
                          },
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: 330,
                    child: ElevatedButton(
                      onPressed: controller.submitCode,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1D2A45),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'تأكيد',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      // يمكن إضافة إعادة إرسال الكود هنا
                    },
                    child: const Text(
                      'إرسال الرمز مرة أخرى؟',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
