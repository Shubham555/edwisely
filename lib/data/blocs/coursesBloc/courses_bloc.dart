import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edwisely/data/model/course/getAllCourses/data.dart';
import 'package:edwisely/main.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../api/api.dart';
import '../../model/course/courseDeckEntity/CourseDeckEntity.dart';
import '../../model/course/courseEntity/CourseEntity.dart';
import '../../model/course/coursesEntity/CoursesEntity.dart';
import '../../model/course/getAllCourses/GetAllCoursesEntity.dart';
import '../../model/course/sectionEntity/SectionEntity.dart';
import '../../model/course/syllabusEntity/SyllabusEntity.dart';

part 'courses_event.dart';

part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CoursesBloc() : super(CoursesInitial());

  @override
  Stream<CoursesState> mapEventToState(
    CoursesEvent event,
  ) async* {
    var currentStrate = state;
    if (event is GetCoursesByFaculty) {
      final response = await EdwiselyApi.dio.get('getFacultyCourses',
          options: Options(
            headers: {
              'Authorization': 'Bearer $loginToken',
            },
          ));

      if (response.statusCode == 200) {
        // if (response.data['status'] != 200) {
        //   SharedPreferences.getInstance().then((value) => value.setString('login_key', null));
        //   yield LoginFailed();
        // } else {
        yield CoursesFetched(CoursesEntity.fromJsonMap(response.data));
        // }
      } else {
        CoursesFetchFailed();
      }
    }
    if (event is GetCoursesList) {
      final subjectResponse = await EdwiselyApi.dio.get('getFacultyCourses',
          options: Options(
            headers: {
              'Authorization': 'Bearer $loginToken',
            },
          ));
      if (subjectResponse.statusCode == 200) {
        List<DropdownMenuItem> subjects = [];
        subjects.add(
          DropdownMenuItem(
            child: Text('All'),
            value: {1234567890: 'All'},
          ),
        );
        CoursesEntity.fromJsonMap(subjectResponse.data).data.forEach(
          (element) {
            subjects.add(
              DropdownMenuItem(
                child: Text(element.name),
                value: {element.id: element.name},
              ),
            );
          },
        );
        yield CoursesListFetched(subjects);
      } else {
        yield CoursesFetchFailed();
      }
    }
    if (event is GetSectionsAndGetCoursesList) {
      final response = await EdwiselyApi.dio.get(
          'getCourseDepartmentSections?university_degree_department_id=$universityDegreeDepartmenId',
          options: Options(headers: {
            'Authorization': 'Bearer $loginToken',
          }));
      final subjectResponse = await EdwiselyApi.dio.get('getFacultyCourses',
          options: Options(
            headers: {
              'Authorization': 'Bearer $loginToken',
            },
          ));
      if (response.statusCode == 200 && subjectResponse.statusCode == 200) {
        List<DropdownMenuItem> subjects = [];
        subjects.add(
          DropdownMenuItem(
            child: Text('All'),
            value: 1234567890,
          ),
        );
        CoursesEntity.fromJsonMap(subjectResponse.data).data.forEach(
          (element) {
            subjects.add(
              DropdownMenuItem(
                child: Text(element.name),
                value: element.id,
              ),
            );
          },
        );
        yield SectionsAndGetCoursesListFetched(
          subjects,
          SectionEntity.fromJsonMap(response.data),
        );
      } else {
        yield CoursesFetchFailed();
      }
    }
    if (event is GetSections) {
      final response = await EdwiselyApi.dio.get(
          'getCourseDepartmentSections?university_degree_department_id=$universityDegreeDepartmenId',
          options: Options(headers: {
            'Authorization': 'Bearer $loginToken',
          }));
      if (response.statusCode == 200) {
        yield SectionsFetched(
          SectionEntity.fromJsonMap(response.data),
        );
      } else {
        yield CoursesFetchFailed();
      }
    }
    if (event is GetCourse) {
      final response = await EdwiselyApi.dio.get(
          'getCourseDetails?subject_semester_id=${event.subjectSemesterId}',
          options: Options(headers: {
            'Authorization': 'Bearer $loginToken',
          }));
      if (response.statusCode == 200) {
        yield CourseAboutDetailsFetched(
          CourseEntity.fromJsonMap(response.data),
        );
      } else {
        yield CoursesFetchFailed();
      }
    }
    if (event is GetCourseSyllabus) {
      final response = await EdwiselyApi.dio.get(
          'getCourseSyllabus?subject_semester_id=${event.subjectSemesterId}',
          options: Options(headers: {
            'Authorization': 'Bearer $loginToken',
          }));
      if (response.statusCode == 200) {
        if (response.data['message'] == 'No data to fetch') {
          yield CoursesFetchFailed();
        } else
          yield CourseSyllabusFetched(
            SyllabusEntity.fromJsonMap(response.data),
          );
      } else {
        yield CoursesFetchFailed();
      }
    }
    if (event is GetAllCourses) {
      final courses = await EdwiselyApi.dio.get('getCourses',
          options: Options(headers: {
            'Authorization': 'Bearer $loginToken',
          }));
      final courseDep = await EdwiselyApi.dio
          .get('getCourseDepartmentSections?university_degree_department_id=71',
              options: Options(headers: {
                'Authorization': 'Bearer $loginToken',
              }));
      if (courses.statusCode == 200 && courseDep.statusCode == 200) {
        yield AllCoursesFetched(GetAllCoursesEntity.fromJsonMap(courses.data),
            SectionEntity.fromJsonMap(courseDep.data));
      } else {
        yield CoursesFetchFailed();
      }
    }
    if (event is SortCourses) {
      if (event.pattern == 1234567890) {
        yield AllCoursesFetched(
            event.originalCourseEntity,
            currentStrate is AllCoursesFetched
                ? currentStrate.sectionEntity
                : null);
      } else {
        GetAllCoursesEntity f = event.originalCourseEntity;
        List<Data> sv = List.from(event.originalCourseEntity.data);
        sv.retainWhere((element) =>
            element.departments.any((element) => element.id == event.pattern));
        f.data = List.unmodifiable(sv);
        yield AllCoursesFetched(
            f,
            currentStrate is AllCoursesFetched
                ? currentStrate.sectionEntity
                : null);
      }
    }
  }
}
