part of 'conducted_bloc.dart';

enum AssessmentType { Objective, Subjective }
enum AssessmentSortBy { Section, Subject }

@immutable
abstract class ConductedEvent {}

class GetConductedTests extends ConductedEvent {
  final AssessmentType assessmentType;
  final AssessmentSortBy assessmentSortBy;

  GetConductedTests(this.assessmentType, this.assessmentSortBy);
}
