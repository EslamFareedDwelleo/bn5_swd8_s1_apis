part of 'users_cubit.dart';

@immutable
sealed class UsersState {}

final class UsersInitial extends UsersState {}

final class LoadingUsersState extends UsersState {}
final class SuccessUsersState extends UsersState {}
final class ErrorUsersState extends UsersState {}
