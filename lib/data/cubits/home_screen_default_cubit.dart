import 'package:bloc/bloc.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:meta/meta.dart';

class HomeScreenDefaultCubit extends Cubit<HomeScreenDefaultState> {
  HomeScreenDefaultCubit() : super(HomeScreenDefaultInitial());

  getHomeScreenContent() async {
    print(DateTime.now().toString());
    final response = await EdwiselyApi.dio
        .get('college/dashboardData?from_date=2020-09-30 18:42:38&delta_days=10&to_date');

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
