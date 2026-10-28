import 'package:bn5_swd8_s1_apis/features/users/cubit/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UsersCubit>().getUsers();
    return Scaffold(
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state is LoadingUsersState) {
            return Center(child: CircularProgressIndicator());
          } else {
            final users = context.read<UsersCubit>().users;
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(users[index].image ?? ""),
                  ),
                  title: Text(users[index].firstName ?? ""),
                  subtitle: Text(users[index].phone ?? ""),
                );
              },
              itemCount: users.length,
            );
          }
        },
      ),
    );
  }
}
