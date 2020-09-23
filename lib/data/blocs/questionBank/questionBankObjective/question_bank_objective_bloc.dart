import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/questionBank/questionBankObjective/QuestionBankObjectiveEntity.dart';
import 'package:edwisely/data/model/questionBank/topicEntity/TopicEntity.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'question_bank_objective_event.dart';

part 'question_bank_objective_state.dart';

class QuestionBankObjectiveBloc extends Bloc<QuestionBankObjectiveEvent, QuestionBankObjectiveState> {
  QuestionBankObjectiveBloc() : super(QuestionBankObjectiveInitial());

  @override
  Stream<QuestionBankObjectiveState> mapEventToState(
    QuestionBankObjectiveEvent event,
  ) async* {
    var currentState = state;

    if (event is GetUnitObjectiveQuestions) {
      final response = await EdwiselyApi()
          .dio()
          .then((value) => value.get('questions/getUnitObjectiveQuestions?subject_id=${event.subjectId}&unit_id=${event.unitId}'));
      final topicsResponse = await EdwiselyApi()
          .dio()
          .then((value) => value.get('questionnaireWeb/getSubjectTopics?subject_id=${event.subjectId}&university_degree_department_id=71'));
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
        yield UnitObjectiveQuestionsFetched(
          QuestionBankObjectiveEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          dropDownItems,
        );
      } else {
        yield QuestionBankObjectiveFetchFailed();
      }
    }
    if (event is GetUnitObjectiveQuestionsByLevel) {
      yield QuestionBankObjectiveInitial();
      final response = await EdwiselyApi()
          .dio()
          .then((value) => value.get('questions/getLevelWiseObjectiveQuestions?unit_id=${event.unitId}&level=${event.level}'));
      if (response.statusCode == 200) {
        QuestionBankObjectiveEntity questionBankObjectiveEntity = QuestionBankObjectiveEntity.fromJsonMap(
          response.data,
        );
        if (questionBankObjectiveEntity == null) {
          yield QuestionBankObjectiveEmpty();
        }
        yield UnitObjectiveQuestionsFetched(
          QuestionBankObjectiveEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          currentState is UnitObjectiveQuestionsFetched ? currentState.dropDownList : null,
        );
      } else {
        yield QuestionBankObjectiveFetchFailed();
      }
    }
    if (event is GetUnitObjectiveQuestionsByTopic) {
      yield QuestionBankObjectiveInitial();
      final response = await EdwiselyApi()
          .dio()
          .then((value) => value.get('questions/getTopicWiseObjectiveQuestions?unit_id=${event.unitId}&topic_id=${event.topic}'));
      if (response.statusCode == 200) {
        yield UnitObjectiveQuestionsFetched(
          QuestionBankObjectiveEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          currentState is UnitObjectiveQuestionsFetched ? currentState.dropDownList : null,
        );
      } else {
        yield QuestionBankObjectiveFetchFailed();
      }
    }
    if (event is GetObjectiveQuestionsByBookmark) {
      yield QuestionBankObjectiveInitial();
      final response = await EdwiselyApi().dio().then((value) => value.get('getBookmarkedQuestions?unit_id=${event.unitId}'));
      if (response.statusCode == 200) {
        yield UnitObjectiveQuestionsFetched(
          QuestionBankObjectiveEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          currentState is UnitObjectiveQuestionsFetched ? currentState.dropDownList : null,
        );
      } else {
        yield QuestionBankObjectiveFetchFailed();
      }
    }
    if (event is GetYourObjectiveQuestions) {
      yield QuestionBankObjectiveInitial();
      final response = await EdwiselyApi().dio().then((value) => value.get('questions/getFacultyAddedObjectiveQuestions?unit_id=${event.unitId}'));
      if (response.statusCode == 200) {
        yield UnitObjectiveQuestionsFetched(
          QuestionBankObjectiveEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          currentState is UnitObjectiveQuestionsFetched ? currentState.dropDownList : null,
        );
      } else {
        yield QuestionBankObjectiveFetchFailed();
      }
    }
  }

  @override
  void onTransition(Transition<QuestionBankObjectiveEvent, QuestionBankObjectiveState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
