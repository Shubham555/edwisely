part of 'objective_bloc.dart';

@immutable
abstract class ObjectiveEvent {}

class GetObjectiveTests extends ObjectiveEvent {}

class GetObjectiveTestsBYSubjectId extends ObjectiveEvent {
  final int subjectId;

  GetObjectiveTestsBYSubjectId(this.subjectId);
}
