part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeAPICall extends HomeEvent {}

class HomeDeleteEvent extends HomeEvent {
  final int index;
  final UserModel model;

  HomeDeleteEvent({required this.index, required this.model});
}

class HomeChangeFav extends HomeEvent {
  final int index;
  final UserModel model;

  HomeChangeFav({required this.index, required this.model});
}

class HomeFavList extends HomeEvent {
  final UserModel model;

  HomeFavList({required this.model});
}

class HomeUnFavList extends HomeEvent {
  final UserModel model;

  HomeUnFavList({required this.model});
}
