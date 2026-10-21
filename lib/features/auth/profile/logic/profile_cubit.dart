import 'package:bn5_swd8_s1_apis/features/auth/profile/logic/profile_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(InitialProfileState());

  String name = "";
  String email = "";
  String image = "";

  void getProfile() async {
    emit(LoadingProfileState());
    try {
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

        emit(SuccessProfileState());
      } else {
        emit(ErrorProfileState());
      }
    } catch (e) {
      emit(ErrorProfileState());
    }
  }
}
