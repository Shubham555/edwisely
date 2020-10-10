import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../main.dart';
import '../api/api.dart';
import '../model/assessment/assessmentQuestions/AssessmentQuestionsEntity.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  QuestionsCubit() : super(QuestionsInitial());
//ye api se aara successful values  m null aara pata nahi bhai ab data kaise aa raha vaha pe bloc mese
  //are ye api m aara
  //too karana kya hai ab ?   check
  getQuestionsToAnAssessment(int testId) async {
    emit(QuestionsInitial());
    final response = await EdwiselyApi.dio.get(
      'questionnaireWeb/getObjectiveTestQuestions?test_id=$testId', options: Options(
        headers: {
          'Authorization': 'Bearer $loginToken',
        })
    );
    print('Questions ${response.data}');

    if (response.statusCode == 200) {
      if (response.data['data'].toString().isNotEmpty) {
        emit(
          QuestionsToAnAssessmentFetched(
            AssessmentQuestionsEntity.fromJsonMap(
              response.data,
            ),
          ),
        );
      } else {
        emit(
          QuestionsToAnAssessmentEmpty(),
        );
      }
    } else {
      emit(
        QuestionsToAnAssessmentFailed(),
      );
    }
  }
}

@immutable
abstract class QuestionsState {}

class QuestionsInitial extends QuestionsState {}

class QuestionsToAnAssessmentFetched extends QuestionsState {
  final AssessmentQuestionsEntity assessmentQuestionsEntity;

  QuestionsToAnAssessmentFetched(this.assessmentQuestionsEntity);
}

class QuestionsToAnAssessmentEmpty extends QuestionsState {}

class QuestionsToAnAssessmentFailed extends QuestionsState {}
