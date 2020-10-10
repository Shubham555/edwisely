import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../main.dart';
import '../api/api.dart';

class QuestionAddCubit extends Cubit<QuestionAddState> {
  QuestionAddCubit() : super(QuestionAddInitial());

  addQuestions(int assessmentId, List<int> questions, List<int> units) async {



    final response = await EdwiselyApi.dio.post(
      'questionnaireWeb/editObjectiveTestQuestions',
      options: Options(headers: {
        'Authorization': 'Bearer $loginToken',
      }),
      data: FormData.fromMap(
        {
          'test_id': assessmentId,
          'questions': jsonEncode(questions),
          'units': jsonEncode([]),
        },
      ),
    );

    if (response.data['message'] == 'Successfully updated the questions') {
      emit(QuestionsAdded());
    } else {
      emit(QuestionsAdditionFailed());
    }
  }

  deleteQuestion(int assessmentId, List<int> questions) async {



    final response = await EdwiselyApi.dio.post(
      'questionnaireWeb/editObjectiveTestQuestions',
      data: FormData.fromMap(
        {
          'test_id': assessmentId,
          'questions': jsonEncode(questions),
          'units': jsonEncode([]),
        },
      ),
      options: Options(headers: {
        'Authorization': 'Bearer $loginToken',
      }),
    );

    if (response.data['message'] == 'Successfully updated the questions') {
      emit(QuestionsAdded());
    } else {
      emit(QuestionsAdditionFailed());
    }
  }
}

@immutable
abstract class QuestionAddState {}

class QuestionAddInitial extends QuestionAddState {}

class QuestionsAdded extends QuestionAddState {}

class QuestionsAdditionFailed extends QuestionAddState {}
