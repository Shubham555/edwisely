import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/questionBank/questionBankObjective/QuestionBankObjectiveEntity.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

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
      final response = await EdwiselyApi.dio.get(
          'questions/getUnitObjectiveQuestions?subject_id=${event.subjectId}&unit_id=${event.unitId}');
      if (response.statusCode == 200) {
        QuestionBankObjectiveEntity questionEntity =
            QuestionBankObjectiveEntity.fromJsonMap(
          response.data,
        );
        List<DropdownMenuItem> dropDownMenuItem = [
              DropdownMenuItem(
                child: Text('All'),
                value: 1234567890,
              ),
            ] +
            questionEntity.data
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e.type),
                    value: e.id,
                  ),
                )
                .toList();
        yield UnitObjectiveQuestionsFetched(
          QuestionBankObjectiveEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          dropDownMenuItem.toSet().toList(),
        );
      } else {
        yield QuestionBankObjectiveFetchFailed();
      }
    }
    if (event is GetUnitObjectiveQuestionsByLevel) {
      yield QuestionBankObjectiveInitial();
      final response = await EdwiselyApi.dio.get(
          'questions/getLevelWiseObjectiveQuestions?unit_id=${event.unitId}&level=${event.level}');
      if (response.statusCode == 200) {
        QuestionBankObjectiveEntity questionEntity =
            QuestionBankObjectiveEntity.fromJsonMap(
          response.data,
        );
        List<DropdownMenuItem> dropDownMenuItem = [
              DropdownMenuItem(
                child: Text('All'),
                value: 1234567890,
              ),
            ] +
            questionEntity.data
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e.type),
                    value: e.id,
                  ),
                )
                .toList();

        yield UnitObjectiveQuestionsFetched(
          QuestionBankObjectiveEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          dropDownMenuItem.toSet().toList(),
        );
      } else {
        yield QuestionBankObjectiveFetchFailed();
      }
    }
    if (event is GetUnitObjectiveQuestionsByTopic) {
      yield QuestionBankObjectiveInitial();
      final response = await EdwiselyApi.dio.get(
          'questions/getTopicWiseObjectiveQuestions?unit_id=${event.unitId}&topic_id=${event.topic}');
      if (response.statusCode == 200) {
        QuestionBankObjectiveEntity questionEntity =
            QuestionBankObjectiveEntity.fromJsonMap(
          response.data,
        );
        List<DropdownMenuItem> dropDownMenuItem = [
              DropdownMenuItem(
                child: Text('All'),
                value: 1234567890,
              ),
            ] +
            questionEntity.data
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e.type),
                    value: e.id,
                  ),
                )
                .toList();

        yield UnitObjectiveQuestionsFetched(
          QuestionBankObjectiveEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          dropDownMenuItem.toSet().toList(),
        );
      } else {
        yield QuestionBankObjectiveFetchFailed();
      }
    }
    //todo api not avialable
    // if (event is GetObjectiveQuestionsByBookmark) {
    //   yield QuestionBankObjectiveInitial();
    //   final response = await EdwiselyApi.dio
    //       .get('getBookmarkedQuestions?unit_id=${event.unitId}');
    //   if (response.statusCode == 200) {
    //     QuestionBankObjectiveEntity questionEntity =
    //         QuestionBankObjectiveEntity.fromJsonMap(
    //       response.data,
    //     );
    //     List<DropdownMenuItem> dropDownMenuItem = [
    //           DropdownMenuItem(
    //             child: Text('All'),
    //             value: 1234567890,
    //           ),
    //         ] +
    //         questionEntity.data
    //             .map(
    //               (e) => DropdownMenuItem(
    //                 child: Text(e.type),
    //                 value: e.id,
    //               ),
    //             )
    //             .toList();
    //
    //     yield UnitObjectiveQuestionsFetched(
    //       QuestionBankObjectiveEntity.fromJsonMap(
    //         response.data,
    //       ),
    //       event.unitId,
    //       dropDownMenuItem.toSet().toList(),
    //     );
    //   } else {
    //     yield QuestionBankObjectiveFetchFailed();
    //   }
    // }
    if (event is GetYourObjectiveQuestions) {
      yield QuestionBankObjectiveInitial();
      final response = await EdwiselyApi.dio.get(
          'questions/getFacultyAddedObjectiveQuestions?unit_id=${event.unitId}');
      if (response.statusCode == 200) {
        QuestionBankObjectiveEntity questionEntity =
            QuestionBankObjectiveEntity.fromJsonMap(
          response.data,
        );
        List<DropdownMenuItem> dropDownMenuItem = [
              DropdownMenuItem(
                child: Text('All'),
                value: 1234567890,
              ),
            ] +
            questionEntity.data
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e.type),
                    value: e.id,
                  ),
                )
                .toList();

        yield UnitObjectiveQuestionsFetched(
          QuestionBankObjectiveEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          dropDownMenuItem.toSet().toList(),
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
