import 'package:bloc/bloc.dart';
import 'package:bn5_swd8_s1_apis/features/products/models/category_model.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  List<CategoryModel> categories = [];

  void getCategories() async {
    emit(LoadingCategoriesState());
    try {
      final response = await Dio().get(
        "https://dummyjson.com/products/categories",
      );
      if (response.statusCode == 200) {
        final list = response.data as List;

        categories = list
            .map((e) => CategoryModel(name: e["name"], slug: e["slug"]))
            .toList();

        emit(SuccessCategoriesState());
      } else {
        emit(ErrorCategoriesState());
      }
    } catch (e) {
      emit(ErrorCategoriesState());
    }
  }
}
