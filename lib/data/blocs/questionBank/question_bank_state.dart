part of 'question_bank_bloc.dart';

@immutable
abstract class QuestionBankState {}

class QuestionBankInitial extends QuestionBankState {}

class QuestionBankFetchFailed extends QuestionBankState {}

class UnitQuestionsFetched extends QuestionBankState {
  final QuestionBankAllEntity questionBankAllEntity;

  UnitQuestionsFetched(this.questionBankAllEntity);
}
