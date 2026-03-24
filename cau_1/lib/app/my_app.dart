import 'package:flutter/material.dart';
import '../views/register_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register Form Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF004D40),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF004D40)),
      ),
      home: const RegisterPage(),
    );
  }
}
