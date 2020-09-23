import 'package:bloc/bloc.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/course/courseContent/CourseContentEntity.dart';
import 'package:meta/meta.dart';

class CourseContentCubit extends Cubit<CourseContentState> {
  CourseContentCubit() : super(CourseContentInitial());

  getCourseContent(int unitId, int semesterId) async {
    final response = await EdwiselyApi().dio().then(
          (value) => value.get('getCourseContent?unit_id=$unitId&subject_semester_id=$semesterId'),
        );
    if (response.data['message'] == 'Successfully updated the course details') {
      emit(
        CourseContentFetched(
          CourseContentEntity.fromJsonMap(
            response.data,
          ),
        ),
      );
    } else {
      emit(
        CourseContentFailed(
          response.data['message'],
        ),
      );
    }
  }
}

@immutable
abstract class CourseContentState {}

class CourseContentInitial extends CourseContentState {}

class CourseContentFetched extends CourseContentState {
  final CourseContentEntity courseContentEntity;

  CourseContentFetched(this.courseContentEntity);
}

class CourseContentFailed extends CourseContentState {
  final String error;

  CourseContentFailed(this.error);
}
