import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:publishing_house/controller/register_controller.dart';
import '../utils/validation.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  var isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    // Ensure fresh controller instance
    Get.delete<RegisterController>();
  }

  RegisterController get controller => Get.put(RegisterController());

  Future<void> _pickImage(
    TextEditingController textController,
    Rx<Uint8List?> imageBytesRx,
  ) async {
    final data = await ImagePickerWeb.getImageAsBytes();
    if (data != null) {
      imageBytesRx.value = data;
      textController.text = "تم اختيار صورة";
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                    vertical: 30,
                  ),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'إنشاء حساب',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 24),
                        _buildTextField(
                          'اسم دار النشر',
                          controller.nameController,
                          (val) => validInput(val!, 3, 50),
                        ),
                        _buildTextField(
                          'الإيميل',
                          controller.emailController,
                          (val) => validInput(val!, 5, 50, type: 'email'),
                        ),
                        _buildImagePickerField(
                          label: 'ترخيص وزارة الإعلام',
                          controller: controller.licenseController,
                          imageBytesRx: controller.licenseImageBytes,
                        ),
                        Obx(
                          () =>
                              controller.licenseError.value.isNotEmpty
                                  ? Text(
                                    controller.licenseError.value,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  )
                                  : SizedBox(),
                        ),
                        _buildImagePickerField(
                          label: 'الشعار',
                          controller: controller.logoController,
                          imageBytesRx: controller.logoImageBytes,
                        ),
                        Obx(
                          () =>
                              controller.logoError.value.isNotEmpty
                                  ? Text(
                                    controller.logoError.value,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  )
                                  : SizedBox(),
                        ),
                        Obx(
                          () => _buildPasswordField(
                            'كلمة المرور',
                            controller.passwordController,
                            controller.showPassword.value,
                            controller.togglePasswordVisibility,
                            (val) => validInput(val!, 8, 100),
                          ),
                        ),
                        Obx(
                          () => _buildPasswordField(
                            'تأكيد كلمة المرور',
                            controller.confirmPasswordController,
                            controller.showConfirmPassword.value,
                            controller.toggleConfirmPasswordVisibility,
                            (val) =>
                                val != controller.passwordController.text
                                    ? 'كلمة المرور غير متطابقة'
                                    : null,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text(
                              'أوافق على شروط سياسة الخصوصية',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: 8),
                            Checkbox(value: true, onChanged: null),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 42,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1D2A45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              print('Register clicked');
                              controller.register();
                            },
                            child: Obx(() {
                              return controller.isLoading.value
                                  ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                  : const Text(
                                    'إنشاء حساب',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  );
                            }),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: GestureDetector(
                            onTap: () => Get.toNamed('/login'),
                            child: const Text.rich(
                              TextSpan(
                                text: 'لديك حساب بالفعل؟ ',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'تسجيل دخول',
                                    style: TextStyle(
                                      color: Color(0xFF1D2A45),
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (screenWidth >= 600)
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/register_illustration.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String? Function(String?)? validator, {
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
              children:
                  required
                      ? [
                        const TextSpan(
                          text: ' *',
                          style: TextStyle(color: Colors.red),
                        ),
                      ]
                      : [],
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            textAlign: TextAlign.right,
            validator: validator,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF1F1F1),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePickerField({
    required String label,
    required TextEditingController controller,
    required Rx<Uint8List?> imageBytesRx,
    bool required = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RichText(
            textDirection: TextDirection.rtl,
            text: TextSpan(
              text: label,
              style: const TextStyle(color: Colors.black, fontSize: 13),
              children:
                  required
                      ? [
                        const TextSpan(
                          text: ' *',
                          style: TextStyle(color: Colors.red),
                        ),
                      ]
                      : [],
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () => _pickImage(controller, imageBytesRx),
            child: AbsorbPointer(
              child: TextFormField(
                controller: controller,
                readOnly: true,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF1F1F1),
                  suffixIcon: Icon(Icons.image, color: Colors.grey.shade700),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue.shade900),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Obx(() {
            final imageBytes = imageBytesRx.value;
            if (imageBytes != null) {
              return Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: MemoryImage(imageBytes),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
        ],
      ),
    );
  }

  Widget _buildPasswordField(
    String label,
    TextEditingController controller,
    bool obscure,
    VoidCallback toggleVisibility,
    String? Function(String?)? validator,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '$label *',
            textDirection: TextDirection.rtl,
            style: const TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 4),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              TextFormField(
                controller: controller,
                obscureText: obscure,
                textAlign: TextAlign.right,
                validator: validator,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF1F1F1),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue.shade900),
                  ),
                ),
              ),
              Positioned(
                left: 10,
                child: IconButton(
                  icon: Icon(
                    obscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey.shade700,
                  ),
                  onPressed: toggleVisibility,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
