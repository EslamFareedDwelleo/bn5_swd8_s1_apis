import 'package:bn5_swd8_s1_apis/features/auth/login/login_screen.dart';
import 'package:bn5_swd8_s1_apis/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final box = Hive.box("userBox");

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              box.get("accessToken", defaultValue: null) == null
              ? LoginScreen()
              : HomeScreen(),
        ),
      );
    });
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(child: Icon(Icons.ac_unit, color: Colors.white, size: 50)),
    );
  }
}
