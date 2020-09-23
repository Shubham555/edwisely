import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/assessment/studentsSection/StudentsEntity.dart';
import 'package:edwisely/data/model/course/sectionEntity/SectionEntity.dart';
import 'package:meta/meta.dart';

class SendAssessmentCubit extends Cubit<SendAssessmentState> {
  SendAssessmentCubit() : super(SendAssessmentInitial());

  getSections(int universityDepartmentId) async {
    final sectionResponse = await EdwiselyApi().dio().then((value) => value.get(
        //todo change to event
        'getCourseDepartmentSections?university_degree_department_id=71'));
    if (sectionResponse.statusCode == 200) {
      emit(
        SendAssessmentSectionsFetched(
          SectionEntity.fromJsonMap(
            sectionResponse.data,
          ),
        ),
      );
    }
  }

  sendAssessment(
    String name,
    String description,
    String doe,
    List<int> questions,
    String timeLimit,
    List<int> students,
    int testId,
    String startTime,
  ) async {
    final response = await EdwiselyApi().dio().then((value) => value.post(
          'questionnaireWeb/editObjectiveTest',
          data: FormData.fromMap(
            {
              'name': name,
              'description': description,
              'doe': doe,
              'questions': jsonEncode(questions),
              'timelimit': timeLimit,
              'students': jsonEncode(students),
              'test_id': testId,
              'starttime': startTime
            },
          ),
        ));
    if (response.data['message'] == 'Successfully updated the questions') {
      emit(
        TestSent(),
      );
    }
  }
}

@immutable
abstract class SendAssessmentState {}

class SendAssessmentInitial extends SendAssessmentState {}

class SendAssessmentSectionsFetched extends SendAssessmentState {
  final SectionEntity sectionEntity;

  SendAssessmentSectionsFetched(this.sectionEntity);
}

class SendAssessmentFailed extends SendAssessmentState {}

class SendAssessmentEmpty extends SendAssessmentState {}

class TestSent extends SendAssessmentState {}

class SendAssessmentStudentsFetched extends SendAssessmentState {
  final StudentsEntity studentsEntity;

  SendAssessmentStudentsFetched(this.studentsEntity);
}
