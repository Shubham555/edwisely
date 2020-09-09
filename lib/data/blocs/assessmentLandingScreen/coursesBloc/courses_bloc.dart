import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/assessment/coursesEntity/CoursesEntity.dart';
import 'package:edwisely/data/model/assessment/sectionEntity/SectionEntity.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'courses_event.dart';

part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CoursesBloc() : super(CoursesInitial());

  @override
  Stream<CoursesState> mapEventToState(
    CoursesEvent event,
  ) async* {
    if (event is GetCoursesByFaculty) {
      final response = await EdwiselyApi.dio.get('getFacultyCourses');
      if (response.statusCode == 200) {
        yield CoursesFetched(CoursesEntity.fromJsonMap(response.data));
      } else {
        CoursesFetchFailed();
      }
    }
    if (event is GetCoursesList) {
      final subjectResponse = await EdwiselyApi.dio.get('getFacultyCourses');
      if (subjectResponse.statusCode == 200) {
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
        yield CoursesListFetched(subjects);
      } else {
        yield CoursesFetchFailed();
      }
    }
    if (event is GetSectionsAndGetCoursesList) {
      final response = await EdwiselyApi.dio.get(
          //todo change to event
          'getCourseDepartmentSections?university_degree_department_id=71');
      final subjectResponse = await EdwiselyApi.dio.get('getFacultyCourses');
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
          //todo change to event
          'getCourseDepartmentSections?university_degree_department_id=71');
      print(response.data);
      if (response.statusCode == 200) {
        yield SectionsFetched(
          SectionEntity.fromJsonMap(response.data),
        );
      } else {
        yield CoursesFetchFailed();
      }
    }
  }
}
