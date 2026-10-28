import 'package:bloc/bloc.dart';
import 'package:bn5_swd8_s1_apis/features/users/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());

  List<UserModel> users = [];

  void getUsers() async {
    emit(LoadingUsersState());
    try {
      final response = await Dio().get("https://dummyjson.com/users");
      if (response.statusCode == 200) {
        final data = response.data["users"] as List;

        users = data.map((e) => UserModel.fromJson(e)).toList();

        emit(SuccessUsersState());
      } else {
        emit(ErrorUsersState());
      }
    } catch (e) {
      emit(ErrorUsersState());
    }
  }
}
