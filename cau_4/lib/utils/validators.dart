import 'regex_patterns.dart';

class Validators {

  static String? requiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName không được để trống';
    }
    return null;
  }

  static String? dateValidator(DateTime? selectedDate) {
    if (selectedDate == null) {
      return 'Vui lòng chọn ngày';
    }
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (selectedDate.isBefore(today)) {
      return 'Ngày không hợp lệ (trong quá khứ)';
    }
    return null;
  }
}
