part of 'courses_bloc.dart';

@immutable
abstract class CoursesState {}

class CoursesInitial extends CoursesState {}

class CoursesFetched extends CoursesState {
  final CoursesEntity coursesEntity;

  CoursesFetched(this.coursesEntity);
}

class CoursesFetchFailed extends CoursesState {}

class SectionsFetched extends CoursesState {
  final SectionEntity sections;

  SectionsFetched(this.sections);
}

class CoursesListFetched extends CoursesState {
  final List<DropdownMenuItem> subjects;

  CoursesListFetched(this.subjects);
}

class SectionsAndGetCoursesListFetched extends CoursesState {
  final List<DropdownMenuItem> subjects;
  final SectionEntity sections;

  SectionsAndGetCoursesListFetched(this.subjects, this.sections);
}
