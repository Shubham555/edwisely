import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/questionBank/questionBankAll/QuestionBankAllEntity.dart';
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
        yield UnitQuestionsFetched(
          QuestionBankAllEntity.fromJsonMap(
            response.data,
          ),
        );
        print('fetch yield');
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
