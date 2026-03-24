class Validators {

  static String? requiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName không được để trống';
    }
    return null;
  }

  static String? ageValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tuổi không được để trống';
    }
    final age = int.tryParse(value);
    if (age == null || age <= 0) {
      return 'Tuổi phải > 0';
    }
    return null;
  }

  static String? atLeastOneSelected(List<bool> selections, String message) {
    if (!selections.contains(true)) {
      return message;
    }
    return null;
  }
}
