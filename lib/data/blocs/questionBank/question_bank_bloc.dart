import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/questionBank/questionBankAll/QuestionBankAllEntity.dart';
import 'package:edwisely/data/model/questionBank/topicEntity/TopicEntity.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

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
      final response = await EdwiselyApi().dio().then((value) => value.get('questions/getUnitQuestions?subject_id=${event.subjectId}&unit_id=${event.unitId}'));
      //todo fix university_degree_department

      final topicsResponse = await EdwiselyApi().dio().then((value) => value.get('questionnaireWeb/getSubjectTopics?subject_id=${event.subjectId}&university_degree_department_id=71'));
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
        yield UnitQuestionsFetched(
          QuestionBankAllEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          dropDownItems,
        );
      } else {
        yield QuestionBankFetchFailed();
      }
    }
    if (event is GetUnitQuestionsByLevel) {
      yield QuestionBankInitial();
      final response = await EdwiselyApi().dio().then((value) => value.get('questions/getLevelWiseQuestions?unit_id=${event.unitId}&level=${event.level}'));
      if (response.statusCode == 200) {
        yield UnitQuestionsFetched(
          QuestionBankAllEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          currentState is UnitQuestionsFetched ? currentState.dropDownList : null,
        );
      } else {
        yield QuestionBankFetchFailed();
      }
    }
    if (event is GetUnitQuestionsByTopic) {
      yield QuestionBankInitial();
      final response = await EdwiselyApi().dio().then((value) => value.get('questions/getTopicWiseQuestions?unit_id=${event.unitId}&topic_id=${event.topic}'));
      if (response.statusCode == 200) {
        yield UnitQuestionsFetched(
          QuestionBankAllEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          currentState is UnitQuestionsFetched ? currentState.dropDownList : null,
        );
      } else {
        yield QuestionBankFetchFailed();
      }
    }
    if (event is GetQuestionsByBookmark) {
      yield QuestionBankInitial();
      final response = await EdwiselyApi().dio().then((value) => value.get('getBookmarkedQuestions?unit_id=${event.unitId}'));
      if (response.statusCode == 200) {
        yield UnitQuestionsFetched(
          QuestionBankAllEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          currentState is UnitQuestionsFetched ? currentState.dropDownList : null,
        );
      } else {
        yield QuestionBankFetchFailed();
      }
    }
    if (event is GetYourQuestions) {
      yield QuestionBankInitial();
      final response = await EdwiselyApi().dio().then((value) => value.get('questions/getFacultyAddedQuestions?unit_id=${event.unitId}'));
      if (response.statusCode == 200) {
        yield UnitQuestionsFetched(
          QuestionBankAllEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          currentState is UnitQuestionsFetched ? currentState.dropDownList : null,
        );
      } else {
        yield QuestionBankFetchFailed();
      }
    }
  }

  @override
  void onTransition(Transition<QuestionBankEvent, QuestionBankState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
