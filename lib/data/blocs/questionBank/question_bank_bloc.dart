import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edwisely/main.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../api/api.dart';
import '../../model/questionBank/questionBankAll/QuestionBankAllEntity.dart';
import '../../model/questionBank/topicEntity/TopicEntity.dart';

part 'question_bank_event.dart';

part 'question_bank_state.dart';

class QuestionBankBloc extends Bloc<QuestionBankEvent, QuestionBankState> {
  QuestionBankBloc() : super(QuestionBankInitial());

  @override
  Stream<QuestionBankState> mapEventToState(
    QuestionBankEvent event,
  ) async* {
    var currentState = state;
    if (event is GetUnitQuestions) {
      final response = await EdwiselyApi.dio.get('questions/getUnitQuestions?subject_id=${event.subjectId}&unit_id=${event.unitId}');

      final topicsResponse = await EdwiselyApi.dio.get('questionnaireWeb/getSubjectTopics?subject_id=${event.subjectId}&university_degree_department_id=$departmentId');
      if (response.statusCode == 200 && topicsResponse.statusCode == 200) {
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
        if (response.data['message'] != 'Successfully fetched the data') {
          yield QuestionBankFetchFailed(response.data['message']);
        } else
          yield UnitQuestionsFetched(
            QuestionBankAllEntity.fromJsonMap(
              response.data,
            ),
            event.unitId,
            dropDownItems,
          );
      }
    }
    if (event is GetUnitQuestionsByLevel) {
      yield QuestionBankInitial();
      final response = await EdwiselyApi.dio.get('questions/getLevelWiseQuestions?unit_id=${event.unitId}&level=${event.level}');
      if (response.statusCode == 200) {
        if (response.data['message'] != 'Successfully fetched the data') {
          yield QuestionBankFetchFailed(response.data['message']);
        } else
          yield UnitQuestionsFetched(
            QuestionBankAllEntity.fromJsonMap(
              response.data,
            ),
            event.unitId,
            currentState is UnitQuestionsFetched ? currentState.dropDownList : null,
          );
      }
    }
    if (event is GetUnitQuestionsByTopic) {
      yield QuestionBankInitial();
      final response = await EdwiselyApi.dio.get('questions/getTopicWiseQuestions?unit_id=${event.unitId}&topic_id=${event.topic}');
      if (response.statusCode == 200) {
        if (response.data['message'] != 'Successfully fetched the data') {
          yield QuestionBankFetchFailed(response.data['message']);
        } else
          yield UnitQuestionsFetched(
            QuestionBankAllEntity.fromJsonMap(
              response.data,
            ),
            event.unitId,
            currentState is UnitQuestionsFetched ? currentState.dropDownList : null,
          );
      }
    }
    if (event is GetQuestionsByBookmark) {
      yield QuestionBankInitial();
      final response = await EdwiselyApi.dio.get('getBookmarkedQuestions?unit_id=${event.unitId}');
      if (response.statusCode == 200) {
        if (response.data['message'] != 'Successfully fetched the data') {
          yield QuestionBankFetchFailed(response.data['message']);
        } else
          yield UnitQuestionsFetched(
            QuestionBankAllEntity.fromJsonMap(
              response.data,
            ),
            event.unitId,
            currentState is UnitQuestionsFetched ? currentState.dropDownList : null,
          );
      }
    }
    if (event is GetYourQuestions) {
      yield QuestionBankInitial();
      final response = await EdwiselyApi.dio.get('questions/getFacultyAddedQuestions?unit_id=${event.unitId}');
      if (response.statusCode == 200) {
        if (response.data['message'] != 'Successfully fetched the data') {
          yield QuestionBankFetchFailed(response.data['message']);
        } else
          yield UnitQuestionsFetched(
            QuestionBankAllEntity.fromJsonMap(
              response.data,
            ),
            event.unitId,
            currentState is UnitQuestionsFetched ? currentState.dropDownList : null,
          );
      }
    }
  }

  @override
  void onTransition(Transition<QuestionBankEvent, QuestionBankState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
