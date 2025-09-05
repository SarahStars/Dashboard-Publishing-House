import 'package:get/get.dart';
import 'package:publishing_house/register/verify_otp_controller.dart';

class VerifyCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyOtpController>(() => VerifyOtpController());
  }
}
