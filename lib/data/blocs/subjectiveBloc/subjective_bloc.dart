import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../main.dart';
import '../../api/api.dart';
import '../../model/assessment/assessmentEntity/AssessmentsEntity.dart';

part 'subjective_event.dart';

part 'subjective_state.dart';

class SubjectiveBloc extends Bloc<SubjectiveEvent, SubjectiveState> {
  SubjectiveBloc() : super(SubjectiveInitial());

  @override
  Stream<SubjectiveState> mapEventToState(
    SubjectiveEvent event,
  ) async* {
    if (event is GetSubjectiveTests) {
      final assessmentResponse =
          await EdwiselyApi.dio.get('questionnaireWeb/getSubjectiveTests',
              options: Options(headers: {
                'Authorization': 'Bearer $loginToken',
              }));

      if (assessmentResponse.statusCode == 200) {
        yield SubjectiveSuccess(
          AssessmentsEntity.fromJsonMap(assessmentResponse.data),
        );
      } else {
        yield SubjectiveFailed();
      }
    }
    if (event is GetSubjectiveTestsBYSubjectId) {
      yield SubjectiveInitial();
      final assessmentResponse = await EdwiselyApi.dio.get(
          'questionnaireWeb/getSubjectWiseSubjectiveTests?subject_id=${event.subjectId}',
          options: Options(headers: {
            'Authorization': 'Bearer $loginToken',
          }));
      if (assessmentResponse.statusCode == 200) {
        if (assessmentResponse.data['message'] == 'No tests to fetch') {
          yield SubjectiveEmpty();
        } else {
          yield SubjectiveSuccess(
            AssessmentsEntity.fromJsonMap(assessmentResponse.data),
          );
        }
      } else {
        yield SubjectiveFailed();
      }
    }
    if (event is CreateSubjectiveQuestionnaire) {
      yield SubjectiveInitial();
      final response =
          await EdwiselyApi.dio.post('questionnaireWeb/createSubjectiveTest',
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
        yield SubjectiveAssessmentCreated(response.data['test_id']);
      } else {
        yield SubjectiveFailed();
      }
    }
  }
}
