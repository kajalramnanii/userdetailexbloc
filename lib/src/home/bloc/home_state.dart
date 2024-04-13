part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final UserModel model;

  HomeSuccess({required this.model});
}

final class HomeError extends HomeState {
  final String error;

  HomeError({required this.error});
}

final class HomeEmpty extends HomeState {}

final class HomeFavState extends HomeState {
  final UserModel model;

  HomeFavState({required this.model});
}
