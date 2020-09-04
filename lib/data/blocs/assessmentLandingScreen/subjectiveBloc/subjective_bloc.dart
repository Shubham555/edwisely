import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/assessment/assessmentEntity/AssessmentsEntity.dart';
import 'package:meta/meta.dart';

part 'subjective_event.dart';
part 'subjective_state.dart';

class SubjectiveBloc extends Bloc<SubjectiveEvent, SubjectiveState> {
  SubjectiveBloc() : super(SubjectiveInitial());

  @override
  Stream<SubjectiveState> mapEventToState(
    SubjectiveEvent event,
  ) async* {
    if (event is GetSubjectiveTests) {
      final response =
      await EdwiselyApi.dio.get('questionnaireWeb/getSubjectiveTests');
      if (response.statusCode == 200) {
        yield SubjectiveSuccess(
          AssessmentsEntity.fromJsonMap(response.data),
        );
      } else {
        yield ObjectiveFailed();
      }
    }
  }
}
