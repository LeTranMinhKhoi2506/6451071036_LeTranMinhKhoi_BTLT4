import 'package:flutter/material.dart';
import '../views/personal_info_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Thông Tin Cá Nhân',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF004D40),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF004D40)),
        inputDecorationTheme: const InputDecorationTheme(
          border: UnderlineInputBorder(),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF004D40), width: 2),
          ),
        ),
      ),
      home: const PersonalInfoPage(),
    );
  }
}
