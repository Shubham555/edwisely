import 'package:bloc/bloc.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class HomeScreenDefaultCubit extends Cubit<HomeScreenDefaultState> {
  HomeScreenDefaultCubit() : super(HomeScreenDefaultInitial());

  getHomeScreenContent() async {
    final response = await EdwiselyApi.dio.get(
      // FIXME: 10/6/2020 change to ${DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())}
        'college/dashboardData?from_date=2020-09-30 18:42:38&delta_days=10&to_date');
    print(response.data['upcoming_events']);
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
