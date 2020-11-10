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
  final int subjectId;


  GetUnitObjectiveQuestionsByLevel(this.level, this.unitId, this.subjectId);
}

class GetUnitObjectiveQuestionsByTopic extends QuestionBankObjectiveEvent {
  final int topic;
  final int unitId;
  final int subjectId;


  GetUnitObjectiveQuestionsByTopic(this.topic, this.unitId, this.subjectId);
}

class GetObjectiveQuestionsByBookmark extends QuestionBankObjectiveEvent {
  final int unitId;
  final int subjectId;


  GetObjectiveQuestionsByBookmark(this.unitId, this.subjectId);
}

class GetYourObjectiveQuestions extends QuestionBankObjectiveEvent {
  final int unitId;
  final int subjectId;


  GetYourObjectiveQuestions(this.unitId, this.subjectId);
}
