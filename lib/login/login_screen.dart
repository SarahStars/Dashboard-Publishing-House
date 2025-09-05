import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:publishing_house/login/login_controller.dart';


class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(
            flex: 5,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Form(
                  key: controller.formKey, // من هنا نستخدم controller مباشرة
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'تسجيل دخول',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 24),
                      _buildTextField(
                        label: 'الإيميل',
                        controller: controller.emailController,
                        validator: controller.validateEmail,
                      ),
                      _buildPasswordField(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: controller.goToForgotPassword,
                          child: const Text(
                            "هل نسيت كلمة المرور؟",
                            style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Obx(() => SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: controller.isLoading.value ? null : controller.login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1D2A45),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: controller.isLoading.value
                                  ? const SizedBox(
                                      height: 22,
                                      width: 22,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'تسجيل الدخول',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                            ),
                          )),
                      const SizedBox(height: 16),
         Row(
  mainAxisAlignment: MainAxisAlignment.center,
  textDirection: TextDirection.rtl,
  children: [
    const Text(
      'ليس لديك حساب؟ ',
      style: TextStyle(color: Colors.black54, fontSize: 13),
    ),
    TextButton(
      onPressed: controller.goToRegister,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: const Text(
        'إنشاء حساب',
        style: TextStyle(
          color: Color(0xFF1D2A45),
          fontSize: 16, // أكبر
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
    ),
  ],
)


                    ],
                  ),
                ),
              ),
            ),
          ),
          if (screenWidth >= 600)
            Expanded(
              flex: 5,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF0F131B),
                  image: DecorationImage(
                    image: AssetImage('images/register_illustration.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool required = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RichText(
            textDirection: TextDirection.rtl,
            text: TextSpan(
              text: label,
              style: const TextStyle(color: Colors.black, fontSize: 13),
              children: required ? [const TextSpan(text: ' *', style: TextStyle(color: Colors.red))] : [],
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            validator: validator,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF1F1F1),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField() {
    return Obx(() => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('كلمة المرور *', textDirection: TextDirection.rtl, style: TextStyle(fontSize: 13)),
              const SizedBox(height: 4),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextFormField(
                    controller: controller.passwordController,
                    obscureText: !controller.showPassword.value,
                    validator: controller.validatePassword,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF1F1F1),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    child: IconButton(
                      icon: Icon(
                        controller.showPassword.value ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey.shade700,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
