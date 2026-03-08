import 'package:flutter/material.dart';
import 'package:stocks/screens/home_screen.dart';
import 'package:stocks/utils/app_colors.dart';
import 'package:get/get.dart';
import '';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finance App',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.darkBackground,
        fontFamily: "Poppins",
      ),
      home: const HomeScreen(),
    );
  }
}
