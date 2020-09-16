part of 'question_bank_bloc.dart';

@immutable
abstract class QuestionBankState {}

class QuestionBankInitial extends QuestionBankState {}

class QuestionBankFetchFailed extends QuestionBankState {}

class UnitQuestionsFetched extends QuestionBankState {
  final QuestionBankAllEntity questionBankAllEntity;
  final int unitId;
  final List<DropdownMenuItem> dropDownList;

  UnitQuestionsFetched(this.questionBankAllEntity, this.unitId, this.dropDownList);
}
