import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../main.dart';
import '../api/api.dart';
import '../model/department/DepartmentEntity.dart';

class DepartmentCubit extends Cubit<DepartmentState> {
  DepartmentCubit() : super(DepartmentInitial());

  getDepartments() async {
    final response = await EdwiselyApi.dio.post('common/getCollegeDepartment',
        data: FormData.fromMap(
          {'college_id': collegeId},
        ),
        options: Options(headers: {
          'Authorization': 'Bearer $loginToken',
        }));
    if (response.data['message'] == true) {
      emit(
        DepartmentFetched(
          DepartmentEntity.fromJsonMap(
            response.data,
          ),
        ),
      );
    } else {
      emit(
        DepartmentError(
          response.data['message'],
        ),
      );
    }
  }
}

@immutable
abstract class DepartmentState {}

class DepartmentInitial extends DepartmentState {}

class DepartmentFetched extends DepartmentState {
  final DepartmentEntity departmentEntity;

  DepartmentFetched(this.departmentEntity);
}

class DepartmentError extends DepartmentState {
  final String error;

  DepartmentError(this.error);
}
