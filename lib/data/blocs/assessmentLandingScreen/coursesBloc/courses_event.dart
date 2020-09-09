part of 'courses_bloc.dart';

@immutable
abstract class CoursesEvent {}

class GetCoursesByFaculty extends CoursesEvent {}

class GetCoursesList extends CoursesEvent {}

class GetSections extends CoursesEvent {
  final int universityDegreeDepartmentId;

  GetSections(this.universityDegreeDepartmentId);
}
class GetSectionsAndGetCoursesList extends CoursesEvent {
  final int universityDegreeDepartmentId;

  GetSectionsAndGetCoursesList(this.universityDegreeDepartmentId);
}

