part of 'question_bank_subjective_bloc.dart';

@immutable
abstract class QuestionBankSubjectiveState {}

class QuestionBankSubjectiveInitial extends QuestionBankSubjectiveState {}

class QuestionBankSubjectiveFetchFailed extends QuestionBankSubjectiveState {
  final String error;
final int unitId;
  QuestionBankSubjectiveFetchFailed(this.error, this.unitId);
}

class QuestionBankSubjectiveEmpty extends QuestionBankSubjectiveState {}

class UnitSubjectiveQuestionsFetched extends QuestionBankSubjectiveState {
  final QuestionBankSubjectiveEntity questionBankSubjectiveEntity;
  final int unitId;
  final List<DropdownMenuItem> dropDownList;

  UnitSubjectiveQuestionsFetched(this.questionBankSubjectiveEntity, this.unitId, this.dropDownList);
}
