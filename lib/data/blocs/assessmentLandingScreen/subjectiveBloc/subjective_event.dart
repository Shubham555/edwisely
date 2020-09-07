part of 'subjective_bloc.dart';

@immutable
abstract class SubjectiveEvent {}

class GetSubjectiveTests extends SubjectiveEvent {}

class GetSubjectiveTestsBYSubjectId extends SubjectiveEvent {
  final int subjectId;

  GetSubjectiveTestsBYSubjectId(this.subjectId);
}

class CreateSubjectiveQuestionnaire extends SubjectiveEvent {
  final String _title;
  final String _description;
  final int _subjectId;

  CreateSubjectiveQuestionnaire(
      this._title, this._description, this._subjectId);
}
