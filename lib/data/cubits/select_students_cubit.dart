import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/assessment/studentsSection/StudentsEntity.dart';
import 'package:meta/meta.dart';

class SelectStudentsCubit extends Cubit<SelectStudentsState> {
  SelectStudentsCubit() : super(SelectStudentsInitial());

  getStudentsInASection(int sectionId, int year) async {
    final response = await EdwiselyApi.dio.post(
      'common/getCollegeDepartmentSectionStudents',
      data: FormData.fromMap(
        {
          'college_department_section_id': sectionId,
          'year': year,
        },
      ),
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
