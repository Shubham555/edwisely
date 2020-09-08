part of 'subjective_bloc.dart';

@immutable
abstract class SubjectiveState {}

class SubjectiveInitial extends SubjectiveState {}

class SubjectiveSuccess extends SubjectiveState {
  final AssessmentsEntity questionsEntity;
  final List<DropdownMenuItem> subjects;

  SubjectiveSuccess(this.questionsEntity, this.subjects);
}

class SubjectiveFailed extends SubjectiveState {}

class SubjectiveEmpty extends SubjectiveState {}

class SubjectiveAssessmentCreated extends SubjectiveState {
  final int assessmentId;

  SubjectiveAssessmentCreated(this.assessmentId);
}
