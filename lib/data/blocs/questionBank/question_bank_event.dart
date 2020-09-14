part of 'question_bank_bloc.dart';

@immutable
abstract class QuestionBankEvent {}

class GetUnitQuestions extends QuestionBankEvent {
  final int subjectId;
  final int unitId;

  GetUnitQuestions(this.subjectId, this.unitId);
}

