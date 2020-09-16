part of 'question_bank_subjective_bloc.dart';

@immutable
abstract class QuestionBankSubjectiveEvent {}
class GetUnitSubjectiveQuestions extends QuestionBankSubjectiveEvent {
  final int subjectId;
  final int unitId;

  GetUnitSubjectiveQuestions(this.subjectId, this.unitId);
}

class GetUnitSubjectiveQuestionsByLevel extends QuestionBankSubjectiveEvent {
  final int level;
  final int unitId;

  GetUnitSubjectiveQuestionsByLevel(this.level, this.unitId);
}

class GetUnitSubjectiveQuestionsByTopic extends QuestionBankSubjectiveEvent {
  final int topic;
  final int unitId;

  GetUnitSubjectiveQuestionsByTopic(this.topic, this.unitId);
}

class GetSubjectiveQuestionsByBookmark extends QuestionBankSubjectiveEvent {
  final int unitId;

  GetSubjectiveQuestionsByBookmark(this.unitId);
}
class GetYourSubjectiveQuestions extends QuestionBankSubjectiveEvent {
  final int unitId;

  GetYourSubjectiveQuestions(this.unitId);
}
