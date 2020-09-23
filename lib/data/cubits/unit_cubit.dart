import 'package:bloc/bloc.dart';
import 'package:edwisely/data/model/course/syllabusEntity/SyllabusEntity.dart';
import 'package:meta/meta.dart';

import '../api/api.dart';

class UnitCubit extends Cubit<UnitState> {
  UnitCubit() : super(UnitInitial());

  getUnitsOfACourse(int subjectSemesterId) async {
    final response = await EdwiselyApi().dio().then((value) => value.get('getCourseSyllabus?subject_semester_id=$subjectSemesterId'));
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data['message'] != 'No data to fetch') {
        emit(
          CourseUnitFetched(
            SyllabusEntity.fromJsonMap(response.data),
          ),
        );
      } else {
        emit(
          CourseUnitEmpty(),
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
