part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}


final class LoadingCategoriesState extends CategoriesState {}
final class SuccessCategoriesState extends CategoriesState {}
final class ErrorCategoriesState extends CategoriesState {}
