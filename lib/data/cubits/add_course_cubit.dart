import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../main.dart';
import '../api/api.dart';

class AddCourseCubit extends Cubit<AddCourseState> {
  AddCourseCubit() : super(AddCourseInitial());

  addCourseToFaculty(
    int subjectId,
    int subjectSemesterId,
    List<int> sections,
  ) async {
    final response = await EdwiselyApi.dio.post(
          'addFacultyCourseSections',
          data: FormData.fromMap(
            {'subject_id': subjectId, 'subject_semester_id': subjectSemesterId, 'sections': jsonEncode(sections)},
          )
        , options: Options(
    headers: {
    'Authorization': 'Bearer $loginToken',
    })
        );
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data['message'] == 'Successfully updated the course details') {
        emit(
          CourseAdded(),
        );
      } else {
        emit(
          CoursesError(
            response.data['message'],
          ),
        );
      }
    } else {
      emit(
        CourseFetchFailed(),
      );
    }
  }
}

@immutable
abstract class AddCourseState {}

class AddCourseInitial extends AddCourseState {}

class CourseFetchFailed extends AddCourseState {}

class CourseAdded extends AddCourseState {}

class CoursesError extends AddCourseState {
  final String error;

  CoursesError(this.error);
}
