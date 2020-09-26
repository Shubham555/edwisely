import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../api/api.dart';
import '../../model/assessment/assessmentEntity/AssessmentsEntity.dart';

part 'conducted_event.dart';

part 'conducted_state.dart';

class ConductedBloc extends Bloc<ConductedEvent, ConductedState> {
  ConductedBloc() : super(ConductedInitial());

  @override
  Stream<ConductedState> mapEventToState(
    ConductedEvent event,
  ) async* {
    if (event is GetObjectiveQuestions) {
      yield ConductedInitial();
      final response = await EdwiselyApi.dio.get('questionnaireWeb/getConductedObjectiveTests');
      if (response.statusCode == 200) {
        yield ConductedSuccess(
          AssessmentsEntity.fromJsonMap(response.data),
        );
      } else {
        yield ConductedFailed();
      }
    }
    if (event is GetSubjectiveQuestions) {
      yield ConductedInitial();
      final response = await EdwiselyApi.dio.get('questionnaireWeb/getConductedSubjectiveTests');
      if (response.statusCode == 200) {
        yield ConductedSuccess(
          AssessmentsEntity.fromJsonMap(response.data),
        );
      } else {
        yield ConductedFailed();
      }
    }
    if (event is GetObjectiveQuestionsByDate) {
      yield ConductedInitial();
      final response = await EdwiselyApi.dio.get('questionnaireWeb/getConductedObjectiveTests?from_date=${event.fromDate}');
      if (response.statusCode == 200) {
        if (response.data['message'] == 'No tests to fetch') {
          yield ConductedEmpty();
        } else
          yield ConductedSuccess(
            AssessmentsEntity.fromJsonMap(response.data),
          );
      } else {
        yield ConductedFailed();
      }
    }
    if (event is GetSubjectiveQuestionsByDate) {
      yield ConductedInitial();
      final response = await EdwiselyApi.dio.get('questionnaireWeb/getConductedSubjectiveTests?from_date=${event.fromDate}');
      if (response.statusCode == 200) {
        if (response.data['message'] == 'No tests to fetch') {
          yield ConductedEmpty();
        } else
          yield ConductedSuccess(
            AssessmentsEntity.fromJsonMap(response.data),
          );
      } else {
        yield ConductedFailed();
      }
    }
    if (event is GetObjectiveQuestionsBySection) {
      yield ConductedInitial();
      final response = await EdwiselyApi.dio.get('questionnaireWeb/getSectionWiseConductedObjectiveTests?section_id=${event.sectionId}');
      if (response.statusCode == 200) {
        if (response.data['message'] == 'No tests to fetch') {
          yield ConductedEmpty();
        } else
          yield ConductedSuccess(
            AssessmentsEntity.fromJsonMap(response.data),
          );
      } else {
        yield ConductedFailed();
      }
    }
    if (event is GetSubjectiveQuestionsBySection) {
      yield ConductedInitial();
      final response = await EdwiselyApi.dio.get('questionnaireWeb/getSectionWiseConductedSubjectiveTests?section_id=${event.sectionId}');
      if (response.statusCode == 200) {
        if (response.data['message'] == 'No tests to fetch') {
          yield ConductedEmpty();
        } else
          yield ConductedSuccess(
            AssessmentsEntity.fromJsonMap(response.data),
          );
      } else {
        yield ConductedFailed();
      }
    }
    if (event is GetObjectiveQuestionsBySubject) {
      yield ConductedInitial();
      final response = await EdwiselyApi.dio.get('questionnaireWeb/getSubjectWiseConductedObjectiveTests?subject_id=${event.subjectId}');
      if (response.statusCode == 200) {
        if (response.data['message'] == 'No tests to fetch') {
          yield ConductedEmpty();
        } else
          yield ConductedSuccess(
            AssessmentsEntity.fromJsonMap(response.data),
          );
      } else {
        yield ConductedFailed();
      }
    }
    if (event is GetSubjectiveQuestionsBySubject) {
      yield ConductedInitial();
      final response = await EdwiselyApi.dio.get('questionnaireWeb/getSubjectWiseConductedSubjectiveTests?subject_id=${event.subjectId}');
      if (response.statusCode == 200) {
        if (response.data['message'] == 'No tests to fetch') {
          yield ConductedEmpty();
        } else
          yield ConductedSuccess(
            AssessmentsEntity.fromJsonMap(response.data),
          );
      } else {
        yield ConductedFailed();
      }
    }
  }
}
