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

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password là bắt buộc';
    }

    RegExp regex = RegExp(RegexPatterns.password);
    if (!regex.hasMatch(value)) {
      return 'Password phải ≥ 8 ký tự, có chữ hoa và số';
    }
    return null;
  }

  /// Cross-field validation
  static String? confirmPasswordValidator(
      String? value,
      String password,
      ) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập lại mật khẩu';
    }

    if (value != password) {
      return 'Mật khẩu xác nhận không khớp';
    }
    return null;
  }
}
