import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/assessment/getunits/GetUnitsEntity.dart';
import 'package:meta/meta.dart';

import '../../main.dart';

class GetUnitsCubit extends Cubit<GetUnitsState> {
  GetUnitsCubit() : super(GetUnitsInitial());

  getUnits(int subjectId) async {
    final response = await EdwiselyApi.dio.get(
        'questionnaire/getUnits?subject_id=$subjectId&university_degree_department_id=71', options: Options(
        headers: {
          'Authorization': 'Bearer $loginToken',
        }));
    print(response.data);
    if (response.data['message'] == 'Successfully fetched the data') {
      emit(
        GetUnitsFetched(
          GetUnitsEntity.fromJsonMap(
            response.data,
          ),
        ),
      );
    } else {
      emit(
        GetUnitsFetchFailed(),
      );
    }
  }
}


@immutable
abstract class GetUnitsState {}

class GetUnitsInitial extends GetUnitsState {}

class GetUnitsFetched extends GetUnitsState {
  final GetUnitsEntity getUnitsEntity;

  GetUnitsFetched(this.getUnitsEntity);
}

class GetUnitsFetchFailed extends GetUnitsState {}
