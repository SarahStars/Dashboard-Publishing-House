import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final int otpLength = 6;

  late List<FocusNode> focusNodes;
  late List<TextEditingController> controllers;

  @override
  void onInit() {
    super.onInit();
    focusNodes = List.generate(otpLength, (_) => FocusNode());
    controllers = List.generate(otpLength, (_) => TextEditingController());

    // التركيز التلقائي على أول خانة
    Future.delayed(Duration.zero, () {
      focusNodes[0].requestFocus();
    });
  }

  @override
  void onClose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    for (var controller in controllers) {
      controller.dispose();
    }
    super.onClose();
  }

  void submitOTP() {
    String otp = controllers.map((c) => c.text).join();
    print("OTP: $otp");
 
  }
}
