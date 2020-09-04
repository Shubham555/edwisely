import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/assessment/assessmentEntity/AssessmentsEntity.dart';
import 'package:edwisely/data/model/assessment/coursesEntity/CoursesEntity.dart';
import 'package:flutter/material.dart';
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
      final assessmentResponse =
          await EdwiselyApi.dio.get('questionnaireWeb/getObjectiveTests');
      final subjectResponse = await EdwiselyApi.dio.get('getFacultyCourses');
      if (assessmentResponse.statusCode == 200 &&
          subjectResponse.statusCode == 200) {
        List<DropdownMenuItem> subjects = [];
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
        yield ObjectiveSuccess(
          AssessmentsEntity.fromJsonMap(assessmentResponse.data),
          subjects: subjects,
        );
      } else {
        yield ObjectiveFailed();
      }
    }
    if (event is GetObjectiveTestsBYSubjectId) {
      yield ObjectiveInitial();
      final assessmentResponse = await EdwiselyApi.dio.get(
          'questionnaireWeb/getSubjectWiseObjectiveTests?subject_id=${event.subjectId}');
      if (assessmentResponse.statusCode == 200) {
        if (assessmentResponse.data['message'] == 'No tests to fetch') {
          yield ObjectiveEmpty();
        } else {
          yield ObjectiveSuccess(
              AssessmentsEntity.fromJsonMap(assessmentResponse.data));
        }
      } else {
        yield ObjectiveFailed();
      }
    }
  }
}
