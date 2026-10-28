import 'package:bn5_swd8_s1_apis/features/auth/profile/logic/profile_cubit.dart';
import 'package:bn5_swd8_s1_apis/features/forgetPassword/check_box_cubit.dart';
import 'package:bn5_swd8_s1_apis/features/forgetPassword/counter_cubit.dart';
import 'package:bn5_swd8_s1_apis/features/forgetPassword/forget_password_screen.dart';
import 'package:bn5_swd8_s1_apis/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox("userBox");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => CounterCubit()),
            BlocProvider(create: (context) => CheckBoxCubit()),
          ],
          child: ForgetPasswordScreen(),
        ),
        // home: BlocProvider(
        //   create: (context) => CheckBoxCubit(),
        //   child: BlocProvider(
        //     create: (context) => CounterCubit(),
        //     child: ForgetPasswordScreen(),
        //   ),
        // ),
      ),
    );
  }
}
