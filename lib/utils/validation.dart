import 'package:publishing_house/constants/messages.dart';

String? validInput(String val, int min, int max, {String? type, String? fieldType}) {
  if (val.isEmpty) {
    return messageInputEmpty;
  }
  if (val.length > max) {
    return "$messageInputMax $max characters";
  }
  if (val.length < min) {
    return "$messageInputMin $min characters";
  }

  if (type == 'email') {
    RegExp emailRegEx = RegExp(r"^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegEx.hasMatch(val)) {
      return messageInputEmailInvalid;
    }
  }
  if (type == 'password') {
    RegExp passwordRegEx = RegExp(r'^[a-zA-Z0-9]+$');
    if (!passwordRegEx.hasMatch(val)) {
      return messageInputPasswordInvalid;
    }
  }

  if (fieldType == 'number_category' && (val != '5' && val != '6')) {
    return messageInputNumberCategoryInvalid;
  }

  return null;
}


String? validateRequiredImageField(String? value, {required String fieldName}) {
  if (value == null || value.trim().isEmpty) {
    return 'لا يمكن إنشاء الحساب بدون $fieldName';
  }
  return null;
}
