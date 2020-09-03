import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/questions/assessmentsEntity.dart';
import 'package:meta/meta.dart';

part 'objective_event.dart';

part 'objective_state.dart';

class ObjectiveBloc extends Bloc<ObjectiveEvent, ObjectiveState> {
  ObjectiveBloc() : super(ObjectiveInitial());

  @override
  Stream<ObjectiveState> mapEventToState(
    ObjectiveEvent event,
  ) async* {
    if (event is GetObjectiveTests) {
      final response =
          await EdwiselyApi.dio.get('questionnaireWeb/getObjectiveTests');
      if (response.statusCode == 200) {
        yield ObjectiveSuccess(
          AssessmentsEntity.fromJsonMap(response.data),
        );
      } else {
        yield ObjectiveFailed();
      }
    }
  }
}
