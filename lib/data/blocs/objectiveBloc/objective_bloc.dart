import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../main.dart';
import '../../api/api.dart';
import '../../model/assessment/assessmentEntity/AssessmentsEntity.dart';

part 'objective_event.dart';

part 'objective_state.dart';

class ObjectiveBloc extends Bloc<ObjectiveEvent, ObjectiveState> {
  ObjectiveBloc() : super(ObjectiveInitial());

  @override
  Stream<ObjectiveState> mapEventToState(
    ObjectiveEvent event,
  ) async* {
    if (event is GetObjectiveTests) {
      yield ObjectiveInitial();
      final assessmentResponse =
          await EdwiselyApi.dio.get('questionnaireWeb/getObjectiveTests',
              options: Options(headers: {
                'Authorization': 'Bearer $loginToken',
              }));
      if (assessmentResponse.statusCode == 200) {
        yield ObjectiveSuccess(
          AssessmentsEntity.fromJsonMap(assessmentResponse.data),
        );
      } else {
        yield ObjectiveFailed();
      }
    }
    if (event is GetObjectiveTestsBYSubjectId) {
      yield ObjectiveInitial();
      final assessmentResponse = await EdwiselyApi.dio.get(
          'questionnaireWeb/getSubjectWiseObjectiveTests?subject_id=${event.subjectId}',
          options: Options(headers: {
            'Authorization': 'Bearer $loginToken',
          }));
      if (assessmentResponse.statusCode == 200) {
        if (assessmentResponse.data['message'] == 'No tests to fetch') {
          yield ObjectiveEmpty();
        } else {
          yield ObjectiveSuccess(
            AssessmentsEntity.fromJsonMap(assessmentResponse.data),
          );
        }
      } else {
        yield ObjectiveFailed();
      }
    }
    if (event is CreateObjectiveQuestionnaire) {
      yield ObjectiveInitial();
      final response =
          await EdwiselyApi.dio.post('questionnaireWeb/createObjectiveTest',
              data: FormData.fromMap(
                {
                  'name': event._title,
                  'description': event._description,
                  'subject_id': event._subjectId,
                },
              ),
              options: Options(headers: {
                'Authorization': 'Bearer $loginToken',
              }));

      if (response.data.toString().contains('Successfully created the test')) {
        yield ObjectiveAssessmentCreated(response.data['test_id']);
      } else {
        yield ObjectiveFailed();
      }
    }
  }
}
