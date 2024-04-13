import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userdetailexbloc/core/api_factory/api_end_points.dart';

import '../../../core/api_factory/api.dart';
import '../models/user_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});

    on<HomeAPICall>((event, emit) async {
      emit(HomeLoading());
      await Api.request(
        path: ApiEndPoints.userData,
        params: {},
        onResponse: (response) {
          UserModel userModel = UserModel.fromJson(response);

          if (userModel.items == null || userModel.items!.isEmpty) {
            emit(HomeEmpty());
          } else {
            emit(HomeSuccess(model: userModel));
          }
        },
        onError: (error) => emit(HomeError(error: error)),
      );
    });

    on<HomeDeleteEvent>((event, emit) {
      // event.model.items!.removeAt(event.index);

      emit(HomeSuccess(model: event.model));
    });

    on<HomeChangeFav>((event, emit) {
      event.model.items![event.index].isFav =
          !event.model.items![event.index].isFav;

      emit(HomeSuccess(model: event.model));
    });

    on<HomeFavList>((event, emit) {
      emit(HomeFavState(model: event.model));
    });
  }
}
