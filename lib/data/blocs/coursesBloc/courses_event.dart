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

class GetCourse extends CoursesEvent {
  final int subjectSemesterId;

  GetCourse(this.subjectSemesterId);
}

class GetCourseSyllabus extends CoursesEvent {
  final int subjectSemesterId;

  GetCourseSyllabus(this.subjectSemesterId);
}

class GetCourseContentData extends CoursesEvent {
  final int unitId;

  GetCourseContentData(this.unitId);
}

class GetAllCourses extends CoursesEvent {}

class AddCourseToFaculty extends CoursesEvent {
  final int subjectId;
  final int subjectSemesterId;
  final List<int> sections;

  AddCourseToFaculty(this.subjectId, this.subjectSemesterId, this.sections);
}
