import 'package:flutter/material.dart';

class Interest {
  final String title;
  final IconData icon;
  bool isSelected;

  Interest({
    required this.title,
    required this.icon,
    this.isSelected = false,
  });
}

class SatisfactionLevel {
  final String title;
  final IconData icon;

  SatisfactionLevel({
    required this.title,
    required this.icon,
  });
}

class SurveyData {
  List<Interest> interests;
  String? satisfactionLevel;
  String notes;

  SurveyData({
    required this.interests,
    this.satisfactionLevel,
    this.notes = '',
  });
}
