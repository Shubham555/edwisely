import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/questionBank/questionBankAll/QuestionBankAllEntity.dart';
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
    if (event is GetUnitQuestions) {
      final response = await EdwiselyApi.dio.get(
          'questions/getUnitQuestions?subject_id=${event.subjectId}&unit_id=${event.unitId}');
      if (response.statusCode == 200) {

        QuestionBankAllEntity questionEntity =
            QuestionBankAllEntity.fromJsonMap(
          response.data,
        );
        List<DropdownMenuItem> dropDownMenuItem = [
              DropdownMenuItem(
                child: Text('All'),
                value: 1234567890,
              ),
            ] +
            questionEntity.data.subjective_questions
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e.type),
                    value: e.id,
                  ),
                )
                .toList() +
            questionEntity.data.objective_questions
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e.type),
                    value: e.id,
                  ),
                )
                .toList();
        yield UnitQuestionsFetched(
          QuestionBankAllEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          dropDownMenuItem.toSet().toList(),
        );
      } else {
        yield QuestionBankFetchFailed();
      }
    }
    if (event is GetUnitQuestionsByLevel) {
      yield QuestionBankInitial();
      final response = await EdwiselyApi.dio.get(
          'questions/getLevelWiseQuestions?unit_id=${event.unitId}&level=${event.level}');
      if (response.statusCode == 200) {
        QuestionBankAllEntity questionEntity =
            QuestionBankAllEntity.fromJsonMap(
          response.data,
        );
        List<DropdownMenuItem> dropDownMenuItem = [
              DropdownMenuItem(
                child: Text('All'),
                value: 1234567890,
              ),
            ] +
            questionEntity.data.subjective_questions
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e.type),
                    value: e.id,
                  ),
                )
                .toList() +
            questionEntity.data.objective_questions
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e.type),
                    value: e.id,
                  ),
                )
                .toList();
        yield UnitQuestionsFetched(
          QuestionBankAllEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          dropDownMenuItem.toSet().toList(),
        );
      } else {
        yield QuestionBankFetchFailed();
      }
    }
    if (event is GetUnitQuestionsByTopic) {
      yield QuestionBankInitial();
      final response = await EdwiselyApi.dio.get(
          'questions/getTopicWiseQuestions?unit_id=${event.unitId}&topic_id=${event.topic}');
      if (response.statusCode == 200) {
        QuestionBankAllEntity questionEntity =
            QuestionBankAllEntity.fromJsonMap(
          response.data,
        );
        List<DropdownMenuItem> dropDownMenuItem = [
              DropdownMenuItem(
                child: Text('All'),
                value: 1234567890,
              ),
            ] +
            questionEntity.data.subjective_questions
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e.type),
                    value: e.id,
                  ),
                )
                .toList() +
            questionEntity.data.objective_questions
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e.type),
                    value: e.id,
                  ),
                )
                .toList();

        yield UnitQuestionsFetched(
          QuestionBankAllEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          dropDownMenuItem.toSet().toList(),
        );
      } else {
        yield QuestionBankFetchFailed();
      }
    }
    if (event is GetQuestionsByBookmark) {
      yield QuestionBankInitial();
      final response = await EdwiselyApi.dio
          .get('getBookmarkedQuestions?unit_id=${event.unitId}');
      if (response.statusCode == 200) {
        QuestionBankAllEntity questionEntity =
            QuestionBankAllEntity.fromJsonMap(
          response.data,
        );
        List<DropdownMenuItem> dropDownMenuItem = [
              DropdownMenuItem(
                child: Text('All'),
                value: 1234567890,
              ),
            ] +
            questionEntity.data.subjective_questions
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e.type),
                    value: e.id,
                  ),
                )
                .toList() +
            questionEntity.data.objective_questions
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e.type),
                    value: e.id,
                  ),
                )
                .toList();

        yield UnitQuestionsFetched(
          QuestionBankAllEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          dropDownMenuItem.toSet().toList(),
        );
      } else {
        yield QuestionBankFetchFailed();
      }
    }
    if (event is GetYourQuestions) {
      yield QuestionBankInitial();
      final response = await EdwiselyApi.dio
          .get('questions/getFacultyAddedQuestions?unit_id=${event.unitId}');
      if (response.statusCode == 200) {
        QuestionBankAllEntity questionEntity =
            QuestionBankAllEntity.fromJsonMap(
          response.data,
        );
        List<DropdownMenuItem> dropDownMenuItem = [
              DropdownMenuItem(
                child: Text('All'),
                value: 1234567890,
              ),
            ] +
            questionEntity.data.subjective_questions
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e.type),
                    value: e.id,
                  ),
                )
                .toList() +
            questionEntity.data.objective_questions
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e.type),
                    value: e.id,
                  ),
                )
                .toList();

        yield UnitQuestionsFetched(
          QuestionBankAllEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          dropDownMenuItem.toSet().toList(),
        );
      } else {
        yield QuestionBankFetchFailed();
      }
    }
  }

  @override
  void onTransition(
      Transition<QuestionBankEvent, QuestionBankState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
