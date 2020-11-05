import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../main.dart';
import '../../../api/api.dart';
import '../../../model/questionBank/questionBankSubjective/QuestionBankSubjectiveEntity.dart';
import '../../../model/questionBank/topicEntity/TopicEntity.dart';

part 'question_bank_subjective_event.dart';

part 'question_bank_subjective_state.dart';

class QuestionBankSubjectiveBloc
    extends Bloc<QuestionBankSubjectiveEvent, QuestionBankSubjectiveState> {
  QuestionBankSubjectiveBloc() : super(QuestionBankSubjectiveInitial());

  @override
  Stream<QuestionBankSubjectiveState> mapEventToState(
    QuestionBankSubjectiveEvent event,
  ) async* {
    var currentState = state;
    if (event is GetUnitSubjectiveQuestions) {
      yield QuestionBankSubjectiveInitial();
      final response = await EdwiselyApi.dio.get(
          'questions/getUnitSubjectiveQuestions?subject_id=${event.subjectId}&unit_id=${event.unitId}',
          options: Options(headers: {
            'Authorization': 'Bearer $loginToken',
          }));
      final topicsResponse = await EdwiselyApi.dio.get(
          'questionnaireWeb/getSubjectTopics?subject_id=${event.subjectId}&university_degree_department_id=71',
          options: Options(headers: {
            'Authorization': 'Bearer $loginToken',
          }));
      if (response.statusCode == 200 && topicsResponse.statusCode == 200) {
        List<DropdownMenuItem> dropDownItems = [];
        dropDownItems.add(
          DropdownMenuItem(
            child: Text('All'),
            value: 1234567890,
          ),
        );
        if (topicsResponse.data['message'] != 'No topics to fetch') {
          TopicEntity topicEntity =
              TopicEntity.fromJsonMap(topicsResponse.data);
          dropDownItems.addAll(
            topicEntity.data.map(
              (e) => DropdownMenuItem(
                child: Text(e.name),
                value: e.id,
              ),
            ),
          );
        }
        if (response.data['message'] != 'Successfully fetched the data') {
          yield QuestionBankSubjectiveFetchFailed(
              response.data['message'], event.unitId);
        } else
          yield UnitSubjectiveQuestionsFetched(
            QuestionBankSubjectiveEntity.fromJsonMap(
              response.data,
            ),
            event.unitId,
            dropDownItems,
          );
      }
    }
    if (event is GetUnitSubjectiveQuestionsByLevel) {
      yield QuestionBankSubjectiveInitial();
      final response = await EdwiselyApi.dio.get(
          'questions/getLevelWiseSubjectiveQuestions?unit_id=${event.unitId}&level=${event.level}',
          options: Options(headers: {
            'Authorization': 'Bearer $loginToken',
          }));
      if (response.statusCode == 200) {
        if (response.data['message'] != 'Successfully fetched the data') {
          yield QuestionBankSubjectiveFetchFailed(
              response.data['message'], event.unitId);
        } else
          yield UnitSubjectiveQuestionsFetched(
            QuestionBankSubjectiveEntity.fromJsonMap(
              response.data,
            ),
            event.unitId,
            currentState is UnitSubjectiveQuestionsFetched
                ? currentState.dropDownList
                : null,
          );
      }
    }
    if (event is GetUnitSubjectiveQuestionsByTopic) {
      yield QuestionBankSubjectiveInitial();
      final response = await EdwiselyApi.dio.get(
          'questions/getTopicWiseSubjectiveQuestions?unit_id=${event.unitId}&topic_id=${event.topic}',
          options: Options(headers: {
            'Authorization': 'Bearer $loginToken',
          }));
      if (response.statusCode == 200) {
        if (response.data['message'] != 'Successfully fetched the data') {
          yield QuestionBankSubjectiveFetchFailed(
              response.data['message'], event.unitId);
        } else
          yield UnitSubjectiveQuestionsFetched(
            QuestionBankSubjectiveEntity.fromJsonMap(
              response.data,
            ),
            event.unitId,
            currentState is UnitSubjectiveQuestionsFetched
                ? currentState.dropDownList
                : null,
          );
      }
    }
    if (event is GetSubjectiveQuestionsByBookmark) {
      yield QuestionBankSubjectiveInitial();
      final response = await EdwiselyApi.dio
          .get('getBookmarkedQuestions?unit_id=${event.unitId}',
              options: Options(headers: {
                'Authorization': 'Bearer $loginToken',
              }));
      if (response.statusCode == 200) {
        if (response.data['message'] != 'Successfully deleted the bookmark') {
          yield QuestionBankSubjectiveFetchFailed(
              response.data['message'], event.unitId);
        } else
          yield UnitSubjectiveQuestionsFetched(
            QuestionBankSubjectiveEntity.fromJsonMap(
              response.data,
            ),
            event.unitId,
            currentState is UnitSubjectiveQuestionsFetched
                ? currentState.dropDownList
                : null,
          );
      }
    }
    if (event is GetYourSubjectiveQuestions) {
      yield QuestionBankSubjectiveInitial();

      final response = await EdwiselyApi.dio.get(
          'questions/getFacultyAddedSubjectiveQuestions?unit_id=${event.unitId}',
          options: Options(headers: {
            'Authorization': 'Bearer $loginToken',
          }));
      if (response.statusCode == 200) {
        if (response.data['message'] != 'Successfully fetched the data') {
          yield QuestionBankSubjectiveFetchFailed(
              response.data['message'], event.unitId);
        } else
          yield UnitSubjectiveQuestionsFetched(
            QuestionBankSubjectiveEntity.fromJsonMap(
              response.data,
            ),
            event.unitId,
            currentState is UnitSubjectiveQuestionsFetched
                ? currentState.dropDownList
                : null,
          );
      }
    }
  }
}
