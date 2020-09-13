part of 'objective_bloc.dart';

@immutable
abstract class ObjectiveEvent {}

class GetObjectiveTests extends ObjectiveEvent {}

class CreateObjectiveQuestionnaire extends ObjectiveEvent {
  final String _title;
  final String _description;
  final int _subjectId;

  CreateObjectiveQuestionnaire(this._title, this._description, this._subjectId);
}

class GetObjectiveTestsBYSubjectId extends ObjectiveEvent {
  final int subjectId;

  GetObjectiveTestsBYSubjectId(this.subjectId);
}

