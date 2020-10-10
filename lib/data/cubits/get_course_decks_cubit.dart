import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../main.dart';
import '../api/api.dart';
import '../model/course/courseDeckEntity/CourseDeckEntity.dart';

class CourseDecksCubit extends Cubit<GetCourseDecksState> {
  CourseDecksCubit() : super(GetCourseDecksInitial());

  getCourseDecks(int unitId) async {
    final response = await EdwiselyApi.dio.get('getCourseDecks?unit_id=$unitId', options: Options(
        headers: {
          'Authorization': 'Bearer $loginToken',
        }));
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data['message'] != 'No data to fetch') {
        emit(
          CourseDecksFetched(
            CourseDeckEntity.fromJsonMap(response.data),
          ),
        );
      } else {
        emit(
          CoursesDeckEmpty(
            response.data['message'],
          ),
        );
      }
    } else {
      emit(
        CoursesDeckFetchFailed(),
      );
    }
  }
}

@immutable
abstract class GetCourseDecksState {}

class GetCourseDecksInitial extends GetCourseDecksState {}

class CourseDecksFetched extends GetCourseDecksState {
  final CourseDeckEntity courseDeckEntity;

  CourseDecksFetched(this.courseDeckEntity);
}

class CoursesDeckEmpty extends GetCourseDecksState {
  final String error;

  CoursesDeckEmpty(this.error);
}

class CoursesDeckFetchFailed extends GetCourseDecksState {}
