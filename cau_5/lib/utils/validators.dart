import 'regex_patterns.dart';

class Validators {

  static String? requiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName không được để trống';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email không được để trống';
    }

    RegExp regex = RegExp(RegexPatterns.email);
    if (!regex.hasMatch(value)) {
      return 'Email không đúng định dạng';
    }
    return null;
  }
}
