part of 'subjective_bloc.dart';

@immutable
abstract class SubjectiveState {}

class SubjectiveInitial extends SubjectiveState {}

class SubjectiveSuccess extends SubjectiveState {
  final AssessmentsEntity questionsEntity;

  SubjectiveSuccess(this.questionsEntity);
}

class ObjectiveFailed extends SubjectiveState {}
