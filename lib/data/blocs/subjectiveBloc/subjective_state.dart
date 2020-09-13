part of 'subjective_bloc.dart';

@immutable
abstract class SubjectiveState {}

class SubjectiveInitial extends SubjectiveState {}

class SubjectiveEmpty extends SubjectiveState {}

class SubjectiveSuccess extends SubjectiveState {
  final AssessmentsEntity questionsEntity;

  SubjectiveSuccess(this.questionsEntity);
}

class SubjectiveFailed extends SubjectiveState {}

class SubjectiveAssessmentCreated extends SubjectiveState {
  final int assessmentId;

  SubjectiveAssessmentCreated(this.assessmentId);
}
