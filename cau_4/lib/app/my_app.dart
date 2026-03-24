import 'package:flutter/material.dart';
import '../views/booking_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking Form Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF00332E),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00332E)),
      ),
      home: const BookingPage(),
    );
  }
}
