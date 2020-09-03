part of 'objective_bloc.dart';

@immutable
abstract class ObjectiveState {}

class ObjectiveInitial extends ObjectiveState {}

class ObjectiveSuccess extends ObjectiveState {
  final AssessmentsEntity questionsEntity;

  ObjectiveSuccess(this.questionsEntity);
}

class ObjectiveFailed extends ObjectiveState {}
