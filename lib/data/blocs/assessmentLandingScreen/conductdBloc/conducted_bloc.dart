import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/questions/assessmentsEntity.dart';
import 'package:meta/meta.dart';

part 'conducted_event.dart';

part 'conducted_state.dart';

class ConductedBloc extends Bloc<ConductedEvent, ConductedState> {
  ConductedBloc() : super(ConductedInitial());

  @override
  Stream<ConductedState> mapEventToState(
    ConductedEvent event,
  ) async* {
    if (event is GetConductedTests) {

      // final response =
      //     await EdwiselyApi.dio.get('questionnaireWeb/getObjectiveTests');
      // if (response.statusCode == 200) {
      //   yield ConductedSuccess(
      //     AssessmentsEntity.fromJsonMap(response.data),
      //   );
      // } else {
      //   yield ConductedFailed();
      // }
    }
  }
}
