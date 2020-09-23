import 'package:bloc/bloc.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/course/courseDeckEntity/CourseDeckEntity.dart';
import 'package:meta/meta.dart';

class CourseDecksCubit extends Cubit<GetCourseDecksState> {
  CourseDecksCubit() : super(GetCourseDecksInitial());

  getCourseDecks(int unitId) async {
    final response = await EdwiselyApi().dio().then(
          (value) => value.get('getCourseDecks?unit_id=$unitId'),
        );
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
