part of 'question_bank_subjective_bloc.dart';

@immutable
abstract class QuestionBankSubjectiveState {}

class QuestionBankSubjectiveInitial extends QuestionBankSubjectiveState {}

class QuestionBankSubjectiveFetchFailed extends QuestionBankSubjectiveState {
  final String error;

  QuestionBankSubjectiveFetchFailed(this.error);
}

class QuestionBankSubjectiveEmpty extends QuestionBankSubjectiveState {}

class UnitSubjectiveQuestionsFetched extends QuestionBankSubjectiveState {
  final QuestionBankSubjectiveEntity questionBankSubjectiveEntity;
  final int unitId;
  final List<DropdownMenuItem> dropDownList;

  UnitSubjectiveQuestionsFetched(this.questionBankSubjectiveEntity, this.unitId, this.dropDownList);
}
