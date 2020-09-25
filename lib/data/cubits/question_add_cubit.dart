import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../api/api.dart';

class QuestionAddCubit extends Cubit<QuestionAddState> {
  QuestionAddCubit() : super(QuestionAddInitial());

  addQuestions(int assessmentId, List<int> questions, List<int> units) async {
    print(assessmentId);
    print(questions);

    final response = await EdwiselyApi().dio().then(
          (value) => value.post(
            'questionnaireWeb/editObjectiveTestQuestions',
            data: FormData.fromMap(
              {
                'test_id': assessmentId,
                'questions': jsonEncode(questions),
                'units': jsonEncode([]),
              },
            ),
          ),
        );
    print(response.data);
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
