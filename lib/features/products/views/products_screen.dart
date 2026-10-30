import 'package:bn5_swd8_s1_apis/features/products/cubits/categoriesCubit/categories_cubit.dart';
import 'package:bn5_swd8_s1_apis/features/products/cubits/productsCubit/products_cubit.dart';
import 'package:bn5_swd8_s1_apis/features/products/views/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductsCubit>().getProducts();
    context.read<CategoriesCubit>().getCategories();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 70,
                child: BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (context, state) {
                    if (state is LoadingCategoriesState) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final categories = context
                        .read<CategoriesCubit>()
                        .categories;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(16),
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(categories[index].name),
                        );
                      },
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                    );
                  },
                ),
              ),
              BlocConsumer<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  if (state is LoadingProductsState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SuccessProductsState) {
                    final products = context.read<ProductsCubit>().products;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                    product: products[index],
                                  ),
                                ),
                              );
                            },
                            leading: Hero(
                              tag: products[index].id,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                  products[index].thumbnail,
                                ),
                              ),
                            ),
                            title: Text(
                              "${products[index].title} : ${products[index].price}",
                            ),
                            subtitle: Text(products[index].description),
                          ),
                        );
                      },
                      itemCount: products.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    );
                  } else {
                    return Center(child: Text("No Products Found"));
                  }
                },
                listener: (context, state) {
                  if (state is ErrorProductsState) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Error in getting products, please try again later",
                          ),
                        );
                      },
                    );
                  }
                },
              ),
              // BlocListener<ProductsCubit, ProductsState>(
              //   listener: (context, state) {
              //     if (state is ErrorProductsState) {
              //       showDialog(
              //         context: context,
              //         builder: (context) {
              //           return AlertDialog(
              //             title: Text(
              //               "Error in getting products, please try again later",
              //             ),
              //           );
              //         },
              //       );
              //     }
              //   },

              //   child: SizedBox(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
