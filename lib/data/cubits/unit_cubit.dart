import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../main.dart';
import '../api/api.dart';
import '../model/course/syllabusEntity/SyllabusEntity.dart';

class UnitCubit extends Cubit<UnitState> {
  UnitCubit() : super(UnitInitial());

  getUnitsOfACourse(int subjectSemesterId) async {
    final response = await EdwiselyApi.dio
        .get('getCourseSyllabus?subject_semester_id=$subjectSemesterId',
            options: Options(headers: {
              'Authorization': 'Bearer $loginToken',
            }));

    if (response.statusCode == 200) {
      if (response.data['message'] == 'No data to fetch') {
        emit(
          CourseUnitEmpty(),
        );
      } else {
        emit(
          CourseUnitFetched(
            SyllabusEntity.fromJsonMap(response.data),
          ),
        );
      }
    } else {
      emit(
        CourseUnitFetchFailed(),
      );
    }
  }
}

@immutable
abstract class UnitState {}

class UnitInitial extends UnitState {}

class CourseUnitFetched extends UnitState {
  final SyllabusEntity units;

  CourseUnitFetched(this.units);
}

class CourseUnitFetchFailed extends UnitState {}

class CourseUnitEmpty extends UnitState {}
