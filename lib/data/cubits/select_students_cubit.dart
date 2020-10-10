import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../main.dart';
import '../api/api.dart';
import '../model/assessment/studentsSection/StudentsEntity.dart';

class SelectStudentsCubit extends Cubit<SelectStudentsState> {
  SelectStudentsCubit() : super(SelectStudentsInitial());

  getStudentsInASection(int sectionId, int year) async {
    emit(
      SelectStudentsInitial(),
    );
    final response = await EdwiselyApi.dio.post(
      'common/getCollegeDepartmentSectionStudents',
      data: FormData.fromMap(
        {
          'college_department_section_id': sectionId,
          'year': year,
        },
      ), options: Options(
        headers: {
          'Authorization': 'Bearer $loginToken',
        })
    );
    if (response.statusCode == 200) {
      emit(
        SelectStudentsStudentsFetched(
          StudentsEntity.fromJsonMap(
            response.data,
          ),
        ),
      );
    } else {
      emit(
        SelectStudentsFailed(),
      );
    }
  }
}

@immutable
abstract class SelectStudentsState {}

class SelectStudentsInitial extends SelectStudentsState {}

class SelectStudentsFailed extends SelectStudentsState {}

class SelectStudentsEmpty extends SelectStudentsState {}

class SelectStudentsStudentsFetched extends SelectStudentsState {
  final StudentsEntity studentsEntity;

  SelectStudentsStudentsFetched(this.studentsEntity);
}
