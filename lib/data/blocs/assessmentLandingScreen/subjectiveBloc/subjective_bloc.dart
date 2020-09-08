import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/assessment/assessmentEntity/AssessmentsEntity.dart';
import 'package:edwisely/data/model/assessment/coursesEntity/CoursesEntity.dart';
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
    var currentState = state;

    if (event is GetSubjectiveTests) {
      final assessmentResponse =
          await EdwiselyApi.dio.get('questionnaireWeb/getSubjectiveTests');
      final subjectResponse = await EdwiselyApi.dio.get('getFacultyCourses');
      if (assessmentResponse.statusCode == 200 &&
          subjectResponse.statusCode == 200) {
        List<DropdownMenuItem> subjects = [];
        subjects.add(
          DropdownMenuItem(
            child: Text('All'),
            value: 1234567890,
          ),
        );
        CoursesEntity.fromJsonMap(subjectResponse.data).data.forEach(
          (element) {
            subjects.add(
              DropdownMenuItem(
                child: Text(element.name),
                value: element.id,
              ),
            );
          },
        );
        yield SubjectiveSuccess(
          AssessmentsEntity.fromJsonMap(assessmentResponse.data),
          subjects,
        );
      } else {
        yield SubjectiveFailed();
      }
    }
    if (event is GetSubjectiveTestsBYSubjectId) {
      yield SubjectiveInitial();
      final assessmentResponse = await EdwiselyApi.dio.get(
          'questionnaireWeb/getSubjectWiseSubjectiveTests?subject_id=${event.subjectId}');
      if (assessmentResponse.statusCode == 200) {
        if (assessmentResponse.data['message'] == 'No tests to fetch') {
          yield SubjectiveEmpty();
        } else {
          yield SubjectiveSuccess(
            AssessmentsEntity.fromJsonMap(assessmentResponse.data),
            currentState is SubjectiveSuccess ? currentState.subjects : null,
          );
        }
      } else {
        yield SubjectiveFailed();
      }
    }
    if (event is CreateSubjectiveQuestionnaire) {
      yield SubjectiveInitial();
      final response = await EdwiselyApi.dio.post(
        'questionnaireWeb/createSubjectiveTest',
        data: FormData.fromMap(
          {
            'name': event._title,
            'description': event._description,
            'subject_id': event._subjectId,
          },
        ),
      );
      if (response.data.toString().contains('Successfully created the test')) {
        yield SubjectiveAssessmentCreated(response.data['test_id']);
      } else {
        yield SubjectiveFailed();
      }
    }
  }
}
