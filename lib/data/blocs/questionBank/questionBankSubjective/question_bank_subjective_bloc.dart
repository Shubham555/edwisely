import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/questionBank/questionBankSubjective/QuestionBankSubjectiveEntity.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'question_bank_subjective_event.dart';

part 'question_bank_subjective_state.dart';

class QuestionBankSubjectiveBloc
    extends Bloc<QuestionBankSubjectiveEvent, QuestionBankSubjectiveState> {
  QuestionBankSubjectiveBloc() : super(QuestionBankSubjectiveInitial());

  @override
  Stream<QuestionBankSubjectiveState> mapEventToState(
    QuestionBankSubjectiveEvent event,
  ) async* {
    if (event is GetUnitSubjectiveQuestions) {
      final response = await EdwiselyApi.dio.get(
          'questions/getUnitSubjectiveQuestions?subject_id=${event.subjectId}&unit_id=${event.unitId}');
      if (response.statusCode == 200) {
        QuestionBankSubjectiveEntity questionEntity =
            QuestionBankSubjectiveEntity.fromJsonMap(
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
        yield UnitSubjectiveQuestionsFetched(
          QuestionBankSubjectiveEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          dropDownMenuItem.toSet().toList(),
        );
      } else {
        yield QuestionBankSubjectiveFetchFailed();
      }
    }
    if (event is GetUnitSubjectiveQuestionsByLevel) {
      yield QuestionBankSubjectiveInitial();
      final response = await EdwiselyApi.dio.get(
          'questions/getLevelWiseSubjectiveQuestions?unit_id=${event.unitId}&level=${event.level}');
      if (response.statusCode == 200) {
        QuestionBankSubjectiveEntity questionEntity =
            QuestionBankSubjectiveEntity.fromJsonMap(
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

        yield UnitSubjectiveQuestionsFetched(
          QuestionBankSubjectiveEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          dropDownMenuItem.toSet().toList(),
        );
      } else {
        yield QuestionBankSubjectiveFetchFailed();
      }
    }
    if (event is GetUnitSubjectiveQuestionsByTopic) {
      yield QuestionBankSubjectiveInitial();
      final response = await EdwiselyApi.dio.get(
          'questions/getTopicWiseSubjectiveQuestions?unit_id=${event.unitId}&topic_id=${event.topic}');
      if (response.statusCode == 200) {
        QuestionBankSubjectiveEntity questionEntity =
            QuestionBankSubjectiveEntity.fromJsonMap(
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

        yield UnitSubjectiveQuestionsFetched(
          QuestionBankSubjectiveEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          dropDownMenuItem.toSet().toList(),
        );
      } else {
        yield QuestionBankSubjectiveFetchFailed();
      }
    }
    //todo api not avialable
    // if (event is GetSubjectiveQuestionsByBookmark) {
    //   yield QuestionBankSubjectiveInitial();
    //   final response = await EdwiselyApi.dio
    //       .get('getBookmarkedQuestions?unit_id=${event.unitId}');
    //   if (response.statusCode == 200) {
    //     QuestionBankSubjectiveEntity questionEntity =
    //         QuestionBankSubjectiveEntity.fromJsonMap(
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
    //     yield UnitSubjectiveQuestionsFetched(
    //       QuestionBankSubjectiveEntity.fromJsonMap(
    //         response.data,
    //       ),
    //       event.unitId,
    //       dropDownMenuItem.toSet().toList(),
    //     );
    //   } else {
    //     yield QuestionBankSubjectiveFetchFailed();
    //   }
    // }
    if (event is GetYourSubjectiveQuestions) {
      yield QuestionBankSubjectiveInitial();
      final response = await EdwiselyApi.dio.get(
          'questions/getFacultyAddedSubjectiveQuestions?unit_id=${event.unitId}');
      if (response.statusCode == 200) {
        QuestionBankSubjectiveEntity questionEntity =
            QuestionBankSubjectiveEntity.fromJsonMap(
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

        yield UnitSubjectiveQuestionsFetched(
          QuestionBankSubjectiveEntity.fromJsonMap(
            response.data,
          ),
          event.unitId,
          dropDownMenuItem.toSet().toList(),
        );
      } else {
        yield QuestionBankSubjectiveFetchFailed();
      }
    }
  }
}
