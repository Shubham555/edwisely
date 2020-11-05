part of 'question_bank_bloc.dart';

@immutable
abstract class QuestionBankEvent {}

class GetUnitQuestions extends QuestionBankEvent {
  final int subjectId;
  final int unitId;

  GetUnitQuestions(this.subjectId, this.unitId);
}

class GetUnitQuestionsByLevel extends QuestionBankEvent {
  final int level;
  final int unitId;

  GetUnitQuestionsByLevel(this.level, this.unitId);
}

class GetUnitQuestionsByTopic extends QuestionBankEvent {
  final int topic;
  final int unitId;

  GetUnitQuestionsByTopic(this.topic, this.unitId);
}

class GetQuestionsByBookmark extends QuestionBankEvent {
  final int unitId;

  GetQuestionsByBookmark(this.unitId);
}

class GetYourQuestions extends QuestionBankEvent {
  final int unitId;

  GetYourQuestions(this.unitId);
}
