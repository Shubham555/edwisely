import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/course/courseDeckEntity/CourseDeckEntity.dart';
import 'package:edwisely/data/model/course/courseEntity/CourseEntity.dart';
import 'package:edwisely/data/model/course/coursesEntity/CoursesEntity.dart';
import 'package:edwisely/data/model/course/getAllCourses/GetAllCoursesEntity.dart';
import 'package:edwisely/data/model/course/sectionEntity/SectionEntity.dart';
import 'package:edwisely/data/model/course/syllabusEntity/SyllabusEntity.dart';
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
          'getCourseDetails?subject_semester_id=${event.subjectSemesterId}');
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
          'getCourseSyllabus?subject_semester_id=${event.subjectSemesterId}');
      if (response.statusCode == 200) {
        yield CourseSyllabusFetched(
          SyllabusEntity.fromJsonMap(response.data),
        );
      } else {
        yield CoursesFetchFailed();
      }
    }
    if (event is GetCourseContentData) {
      final response = await EdwiselyApi.dio.get('getCourseDecks?unit_id=593');
      if (response.statusCode == 200) {
        if (response.data['message'] != 'No data to fetch') {
          yield CourseContentDataFetched(
            CourseDeckEntity.fromJsonMap(response.data),
          );
        } else {
          yield CoursesEmpty();
        }
      } else {
        yield CoursesFetchFailed();
      }
    }
    if (event is GetAllCourses) {
      final response = await Future.wait([
        EdwiselyApi.dio.get('getCourses'),
        EdwiselyApi.dio.get(
            'getCourseDepartmentSections?university_degree_department_id=71'),
      ]);
      if (response[0].statusCode == 200 && response[1].statusCode == 200) {
        yield AllCoursesFetched(
            GetAllCoursesEntity.fromJsonMap(response[0].data),
            SectionEntity.fromJsonMap(response[1].data));
      } else {
        yield CoursesFetchFailed();
      }
    }
    if (event is AddCourseToFaculty) {
      print(event.sections);
      final response = await EdwiselyApi.dio.post(
        'addFacultyCourseSections',
        data: FormData.fromMap(
          {
            'subject_id': event.subjectId,
            'subject_semester_id': event.subjectSemesterId,
            //todo consider other developers
            'sections': event.sections
          },
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        if (response.data['message'] ==
            'Successfully updated the course details') {
          yield CourseAdded();
        }
      } else {
        yield CoursesFetchFailed();
      }
    }
  }

  @override
  void onTransition(Transition<CoursesEvent, CoursesState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
