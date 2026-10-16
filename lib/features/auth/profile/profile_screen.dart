import 'package:bn5_swd8_s1_apis/features/auth/login/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    getProfile();
    super.initState();
  }

  String name = "";
  String email = "";
  String image = "";

  bool loading = true;

  void getProfile() async {
    final response = await Dio().get(
      "https://dummyjson.com/auth/me",
      options: Options(
        headers: {
          "Authorization": "Bearer ${Hive.box("userBox").get("accessToken")}",
        },
      ),
    );
    if (response.statusCode == 200) {
      name = response.data["username"];
      email = response.data["email"];
      image = response.data["image"];
    }

    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                CircleAvatar(radius: 100, backgroundImage: NetworkImage(image)),
                Text(name),
                Text(email),

                ListTile(
                  onTap: () async {
                    await Hive.box("userBox").clear();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  title: Text("Logout"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
    );
  }
}
