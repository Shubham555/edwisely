import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../main.dart';

class HomeScreenDefaultCubit extends Cubit<HomeScreenDefaultState> {
  HomeScreenDefaultCubit() : super(HomeScreenDefaultInitial());

  getHomeScreenContent() async {
    final response = await EdwiselyApi.dio.get(
        'college/dashboardData?from_date=${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}&delta_days=10&to_date',
        options: Options(headers: {
          'Authorization': 'Bearer $loginToken',
        }));

    if (response.data['message'] == 'Successfully fetched the data') {
      emit(
        HomeScreenDefaultFetched(
          response.data,
        ),
      );
    } else {
      emit(
        HomeScreenDefaultFailed(
          response.data['message'],
        ),
      );
    }
  }
}

@immutable
abstract class HomeScreenDefaultState {}

class HomeScreenDefaultInitial extends HomeScreenDefaultState {}

class HomeScreenDefaultFetched extends HomeScreenDefaultState {
  final Map<String, dynamic> map;

  HomeScreenDefaultFetched(this.map);
}

class HomeScreenDefaultFailed extends HomeScreenDefaultState {
  final String error;

  HomeScreenDefaultFailed(this.error);
}
