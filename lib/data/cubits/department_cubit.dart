import 'package:bloc/bloc.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/department/DepartmentEntity.dart';
import 'package:meta/meta.dart';

class DepartmentCubit extends Cubit<DepartmentState> {
  DepartmentCubit() : super(DepartmentInitial());

  getDepartments(int collegeId) async {
    final response = await EdwiselyApi().dio().then(
          (value) => value.get('common/getCollegeDepartment'),
        );
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
