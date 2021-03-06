import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edwisely/main.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../api/api.dart';
import '../../../model/questionBank/questionBankObjective/QuestionBankObjectiveEntity.dart';
import '../../../model/questionBank/topicEntity/TopicEntity.dart';

part 'question_bank_objective_event.dart';

part 'question_bank_objective_state.dart';

class QuestionBankObjectiveBloc
    extends Bloc<QuestionBankObjectiveEvent, QuestionBankObjectiveState> {
  QuestionBankObjectiveBloc() : super(QuestionBankObjectiveInitial());

  @override
  Stream<QuestionBankObjectiveState> mapEventToState(
    QuestionBankObjectiveEvent event,
  ) async* {
    if (event is GetUnitObjectiveQuestions) {
      yield QuestionBankObjectiveInitial();
      final response = await EdwiselyApi.dio.get(
          'questions/getUnitObjectiveQuestions?subject_id=${event.subjectId}&unit_id=${event.unitId}',
          options: Options(headers: {
            'Authorization': 'Bearer $loginToken',
          }));

      if (response.statusCode == 200) {
        if (response.data['message'] != 'Successfully fetched the data') {
          yield QuestionBankObjectiveFetchFailed(
              response.data['message'], event.unitId);
        } else
          yield UnitObjectiveQuestionsFetched(
            QuestionBankObjectiveEntity.fromJsonMap(
              response.data,
            ),
            event.unitId,
            await _getTopics(
              event.subjectId,
            ),
          );
      }
    }
    if (event is GetUnitObjectiveQuestionsByLevel) {
      yield QuestionBankObjectiveInitial();
      final response = await EdwiselyApi.dio.get(
          'questions/getLevelWiseObjectiveQuestions?unit_id=${event.unitId}&level=${event.level}',
          options: Options(headers: {
            'Authorization': 'Bearer $loginToken',
          }));
      if (response.statusCode == 200) {
        if (response.data['message'] == 'No questions') {
          yield QuestionBankObjectiveEmpty(
            event.unitId,
          );
        } else if (response.data['message'] !=
            'Successfully fetched the data') {
          yield QuestionBankObjectiveFetchFailed(
              response.data['message'], event.unitId);
        } else
          yield UnitObjectiveQuestionsFetched(
            QuestionBankObjectiveEntity.fromJsonMap(
              response.data,
            ),
            event.unitId,
            await _getTopics(
              event.subjectId,
            ),
          );
      }
    }
    if (event is GetUnitObjectiveQuestionsByTopic) {
      yield QuestionBankObjectiveInitial();
      final response = await EdwiselyApi.dio.get(
          'questions/getTopicWiseObjectiveQuestions?unit_id=${event.unitId}&topic_id=${event.topic}',
          options: Options(headers: {
            'Authorization': 'Bearer $loginToken',
          }));
      if (response.statusCode == 200) {
        if (response.data['message'] != 'Successfully fetched the data') {
          yield QuestionBankObjectiveFetchFailed(
              response.data['message'], event.unitId);
        } else
          yield UnitObjectiveQuestionsFetched(
            QuestionBankObjectiveEntity.fromJsonMap(
              response.data,
            ),
            event.unitId,
            await _getTopics(
              event.subjectId,
            ),
          );
      }
    }
    if (event is GetObjectiveQuestionsByBookmark) {
      yield QuestionBankObjectiveInitial();
      final response = await EdwiselyApi.dio
          .get('getBookmarkedQuestions?unit_id=${event.unitId}',
              options: Options(headers: {
                'Authorization': 'Bearer $loginToken',
              }));
      if (response.statusCode == 200) {
        if (response.data['message'] != 'Successfully deleted the bookmark') {
          yield QuestionBankObjectiveFetchFailed(
              response.data['message'], event.unitId);
        } else
          QuestionBankObjectiveEntity questionBankObjectiveEntity =   QuestionBankObjectiveEntity.fromJsonMap(
            response.data,
          );
        print('ff');
        // yield UnitObjectiveQuestionsFetched(
        //     null,
        //     event.unitId,
        //     await _getTopics(
        //       event.subjectId,
        //     ),
        //   );
      }
    }
    if (event is GetYourObjectiveQuestions) {
      yield QuestionBankObjectiveInitial();
      final response = await EdwiselyApi.dio.get(
          'questions/getFacultyAddedObjectiveQuestions?unit_id=${event.unitId}',
          options: Options(headers: {
            'Authorization': 'Bearer $loginToken',
          }));
      if (response.statusCode == 200) {
        if (response.data['message'] != 'Successfully fetched the data') {
          yield QuestionBankObjectiveFetchFailed(
              response.data['message'], event.unitId);
        } else
          yield UnitObjectiveQuestionsFetched(
            QuestionBankObjectiveEntity.fromJsonMap(
              response.data,
            ),
            event.unitId,
            await _getTopics(
              event.subjectId,
            ),
          );
      }
    }
  }

  _getTopics(int subjectId) async {
    final topicsResponse = await EdwiselyApi.dio.get(
        'questionnaireWeb/getSubjectTopics?subject_id=$subjectId&university_degree_department_id=$universityDegreeDepartmenId',
        options: Options(headers: {
          'Authorization': 'Bearer $loginToken',
        }));
    List<DropdownMenuItem> dropDownItems = [];
    dropDownItems.add(
      DropdownMenuItem(
        child: Text('All'),
        value: 1234567890,
      ),
    );
    if (topicsResponse.data['message'] != 'No topics to fetch') {
      TopicEntity topicEntity = TopicEntity.fromJsonMap(topicsResponse.data);
      dropDownItems.addAll(
        topicEntity.data.map(
          (e) => DropdownMenuItem(
            child: Text(e.name),
            value: e.id,
          ),
        ),
      );
    }
    return dropDownItems;
  }
}
