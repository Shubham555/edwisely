import 'package:bloc/bloc.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/assessment/assessmentQuestions/AssessmentQuestionsEntity.dart';
import 'package:meta/meta.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  QuestionsCubit() : super(QuestionsInitial());

  getQuestionsToAnAssessment(int testId) async {
    emit(QuestionsInitial());
    final response = await EdwiselyApi().dio().then((value) => value.get(
      'questionnaireWeb/getObjectiveTestQuestions?test_id=$testId',
    ));
    if (response.statusCode == 200) {
      if (response.data['message'] != 'No questions to fetch') {
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
