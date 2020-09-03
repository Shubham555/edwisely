part of 'conducted_bloc.dart';

@immutable
abstract class ConductedState {}

class ConductedInitial extends ConductedState {}

class ConductedSuccess extends ConductedState {
  final AssessmentsEntity questionsEntity;

  ConductedSuccess(this.questionsEntity);
}

class ConductedFailed extends ConductedState {}
