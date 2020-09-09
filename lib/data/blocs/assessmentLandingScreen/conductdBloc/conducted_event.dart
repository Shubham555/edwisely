part of 'conducted_bloc.dart';

@immutable
abstract class ConductedEvent {}

class GetObjectiveQuestions extends ConductedEvent {}

class GetSubjectiveQuestions extends ConductedEvent {}

class GetObjectiveQuestionsByDate extends ConductedEvent {
  final String fromDate;

  GetObjectiveQuestionsByDate(this.fromDate);
}

class GetSubjectiveQuestionsByDate extends ConductedEvent {
  final String fromDate;

  GetSubjectiveQuestionsByDate(this.fromDate);
}

class GetObjectiveQuestionsBySection extends ConductedEvent {
  final String sectionId;

  GetObjectiveQuestionsBySection(this.sectionId);
}

class GetSubjectiveQuestionsBySection extends ConductedEvent {
  final String sectionId;

  GetSubjectiveQuestionsBySection(this.sectionId);
}

class GetObjectiveQuestionsBySubject extends ConductedEvent {
  final String subjectId;

  GetObjectiveQuestionsBySubject(this.subjectId);
}

class GetSubjectiveQuestionsBySubject extends ConductedEvent {
  final String subjectId;

  GetSubjectiveQuestionsBySubject(this.subjectId);
}
