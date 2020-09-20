part of 'question_bank_objective_bloc.dart';

@immutable
abstract class QuestionBankObjectiveEvent {}

class GetUnitObjectiveQuestions extends QuestionBankObjectiveEvent {
  final int subjectId;
  final int unitId;

  GetUnitObjectiveQuestions(this.subjectId, this.unitId);
}

class GetUnitObjectiveQuestionsByLevel extends QuestionBankObjectiveEvent {
  final int level;
  final int unitId;

  GetUnitObjectiveQuestionsByLevel(this.level, this.unitId);
}

class GetUnitObjectiveQuestionsByTopic extends QuestionBankObjectiveEvent {
  final int topic;
  final int unitId;

  GetUnitObjectiveQuestionsByTopic(this.topic, this.unitId);
}

class GetObjectiveQuestionsByBookmark extends QuestionBankObjectiveEvent {
  final int unitId;

  GetObjectiveQuestionsByBookmark(this.unitId);
}

class GetYourObjectiveQuestions extends QuestionBankObjectiveEvent {
  final int unitId;

  GetYourObjectiveQuestions(this.unitId);
}
