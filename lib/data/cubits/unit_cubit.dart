import 'package:bloc/bloc.dart';
import 'package:edwisely/data/model/course/syllabusEntity/SyllabusEntity.dart';
import 'package:meta/meta.dart';

import '../api/api.dart';

class UnitCubit extends Cubit<UnitState> {
  UnitCubit() : super(UnitInitial());

  getUnitsOfACourse(int subjectSemesterId) async {
    final response = await EdwiselyApi.dio
        .get('getCourseSyllabus?subject_semester_id=$subjectSemesterId');
    if (response.statusCode == 200) {
      emit(
        CourseUnitFetched(
          SyllabusEntity.fromJsonMap(response.data),
        ),
      );
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
