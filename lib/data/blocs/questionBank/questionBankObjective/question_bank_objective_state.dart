part of 'question_bank_objective_bloc.dart';

@immutable
abstract class QuestionBankObjectiveState {}

class QuestionBankObjectiveInitial extends QuestionBankObjectiveState {}

class QuestionBankObjectiveFetchFailed extends QuestionBankObjectiveState {}
class QuestionBankObjectiveEmpty extends QuestionBankObjectiveState {}

class UnitObjectiveQuestionsFetched extends QuestionBankObjectiveState {
  final QuestionBankObjectiveEntity questionBankObjectiveEntity;
  final int unitId;
  final List<DropdownMenuItem> dropDownList;

  UnitObjectiveQuestionsFetched(
      this.questionBankObjectiveEntity, this.unitId, this.dropDownList);
}
