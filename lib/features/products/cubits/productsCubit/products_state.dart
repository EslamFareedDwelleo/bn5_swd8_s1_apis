part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}


class LoadingProductsState extends ProductsState {}
class SuccessProductsState extends ProductsState {}
class ErrorProductsState extends ProductsState {}