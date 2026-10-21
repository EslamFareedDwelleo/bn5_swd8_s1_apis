import 'package:bn5_swd8_s1_apis/features/auth/login/login_screen.dart';
import 'package:bn5_swd8_s1_apis/features/auth/profile/logic/profile_cubit.dart';
import 'package:bn5_swd8_s1_apis/features/auth/profile/logic/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Column(
        children: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is LoadingProfileState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is SuccessProfileState) {
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(
                        context.read<ProfileCubit>().image,
                      ),
                    ),
                    Text(context.read<ProfileCubit>().name),
                    Text(context.read<ProfileCubit>().email),
                  ],
                );
              } else {
                return Text("Error");
              }
            },
          ),

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
