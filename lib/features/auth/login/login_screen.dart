import 'package:bn5_swd8_s1_apis/features/home/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passController = TextEditingController();

  final box = Hive.box("userBox");

  bool loading = false;

  void login() async {
    loading = true;
    setState(() {});
    final response = await Dio().post(
      "https://dummyjson.com/auth/login",
      data: {
        "username": usernameController.text,
        "password": passController.text,
      },
    );
    if (response.statusCode == 200) {
      await box.putAll({
        "accessToken": response.data["accessToken"],
        "refreshToken": response.data["refreshToken"],
        "id": response.data["id"],
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }

    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            children: [
              TextField(
                controller: usernameController,
                maxLines: 1,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              TextField(
                controller: passController,
                maxLines: 1,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              loading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      child: Text("Login"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
