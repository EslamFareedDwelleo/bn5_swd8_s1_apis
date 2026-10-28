import 'package:bloc/bloc.dart';
import 'package:bn5_swd8_s1_apis/features/products/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  List<ProductModel> products = [];

  void getProducts() async {
    emit(LoadingProductsState());
    try {
      final response = await Dio().get("https://dummyjson.com/products");
      if (response.statusCode == 200) {
        final data = response.data as Map;
        final list = data["products"] as List;

        products = list
            .map((element) => ProductModel.fromMap(element))
            .toList();

        // for (var element in list) {
        //   products.add(
        // ProductModel(
        //   category: element["category"],
        //   description: element["description"],
        //   id: element["id"],
        //   price: element["price"],
        //   thumbnail: element["thumbnail"],
        //   title: element["title"],
        // ),
        //   );
        // }

        // Data
        emit(SuccessProductsState());
      } else {
        emit(ErrorProductsState());
      }
    } catch (e) {
      emit(ErrorProductsState());
    }
  }
}
