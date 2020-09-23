part of 'courses_bloc.dart';

@immutable
abstract class CoursesState {}

class CoursesInitial extends CoursesState {}

class CoursesEmpty extends CoursesState {}

class CoursesFetched extends CoursesState {
  final CoursesEntity coursesEntity;

  CoursesFetched(this.coursesEntity);
}

class CoursesFetchFailed extends CoursesState {}
class LoginFailed extends CoursesState {}

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

class CourseAboutDetailsFetched extends CoursesState {
  final CourseEntity courseEntity;

  CourseAboutDetailsFetched(this.courseEntity);
}

class CourseSyllabusFetched extends CoursesState {
  final SyllabusEntity syllabusEntity;

  CourseSyllabusFetched(this.syllabusEntity);
}

class CourseContentDataFetched extends CoursesState {
  final CourseDeckEntity courseDeckEntity;

  // final SyllabusEntity syllabusEntity;

  CourseContentDataFetched(
    this.courseDeckEntity,
  );
}

class AllCoursesFetched extends CoursesState {
  final GetAllCoursesEntity getAllCoursesEntity;
  final SectionEntity sectionEntity;

  AllCoursesFetched(this.getAllCoursesEntity, this.sectionEntity);
}

class CourseAdded extends CoursesState {}
