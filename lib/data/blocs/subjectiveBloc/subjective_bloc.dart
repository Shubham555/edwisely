import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/assessment/assessmentEntity/AssessmentsEntity.dart';
import 'package:flutter/material.dart';
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
      final assessmentResponse = await EdwiselyApi().dio().then((value) => value.get('questionnaireWeb/getSubjectiveTests'));

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
      final assessmentResponse = await EdwiselyApi().dio().then((value) => value.get('questionnaireWeb/getSubjectWiseSubjectiveTests?subject_id=${event.subjectId}'));
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
      final response = await EdwiselyApi().dio().then((value) => value.post(
            'questionnaireWeb/createSubjectiveTest',
            data: FormData.fromMap(
              {
                'name': event._title,
                'description': event._description,
                'subject_id': event._subjectId,
              },
            ),
          ));
      print(response.data);
      if (response.data.toString().contains('Successfully created the test')) {
        yield SubjectiveAssessmentCreated(response.data['test_id']);
      } else {
        yield SubjectiveFailed();
      }
    }
  }
}
