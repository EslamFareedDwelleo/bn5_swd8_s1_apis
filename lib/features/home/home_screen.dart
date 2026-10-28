import 'package:bn5_swd8_s1_apis/features/auth/profile/ui/profile_screen.dart';
import 'package:bn5_swd8_s1_apis/features/posts/main/posts_screen.dart';
import 'package:bn5_swd8_s1_apis/features/products/views/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/profile/logic/profile_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  List<Widget> screens = [PostsScreen(), ProductsScreen(), ProfileScreen()];

  @override
  void initState() {
    context.read<ProfileCubit>().getProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.podcasts), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: "Products"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }
}
