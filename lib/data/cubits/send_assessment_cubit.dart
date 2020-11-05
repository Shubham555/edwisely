import 'dart:convert';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../main.dart';
import '../api/api.dart';
import '../model/assessment/studentsSection/StudentsEntity.dart';
import '../model/course/sectionEntity/SectionEntity.dart';

class SendAssessmentCubit extends Cubit<SendAssessmentState> {
  SendAssessmentCubit() : super(SendAssessmentInitial());

  getSections(int universityDepartmentId) async {
    final sectionResponse = await EdwiselyApi.dio.get(
        'getCourseDepartmentSections?university_degree_department_id=$universityDegreeDepartmenId',
        options: Options(headers: {
          'Authorization': 'Bearer $loginToken',
        }));

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
    String timeLimit,
    List<int> students,
    int testId,
    String startTime,
  ) async {
    final response =
        await EdwiselyApi.dio.post('questionnaireWeb/editObjectiveTest',
            data: FormData.fromMap(
              {
                'name': name,
                'description': description,
                'doe': doe,
                'timelimit': timeLimit,
                'students': jsonEncode(students),
                'test_id': testId,
                'starttime': startTime
              },
            ),
            options: Options(headers: {
              'Authorization': 'Bearer $loginToken',
            }));
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
