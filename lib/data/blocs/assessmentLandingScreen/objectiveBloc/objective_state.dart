part of 'objective_bloc.dart';

@immutable
abstract class ObjectiveState {}

class ObjectiveInitial extends ObjectiveState {}

class ObjectiveEmpty extends ObjectiveState {}

class ObjectiveSuccess extends ObjectiveState {
  final AssessmentsEntity questionsEntity;
  final List<DropdownMenuItem> subjects;

  ObjectiveSuccess(this.questionsEntity, this.subjects);
}

class ObjectiveFailed extends ObjectiveState {}
