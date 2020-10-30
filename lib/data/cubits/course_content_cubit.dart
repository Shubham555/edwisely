import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../main.dart';
import '../api/api.dart';
import '../model/course/courseContent/CourseContentEntity.dart';
import '../model/course/courseContent/learning_content.dart';

class CourseContentCubit extends Cubit<CourseContentState> {
  CourseContentCubit() : super(CourseContentInitial());

  getCourseContent(int unitId, int semesterId) async {
    emit(
      CourseContentInitial(),
    );
    final response = await EdwiselyApi.dio
        .get('getCourseContent?unit_id=$unitId&subject_semester_id=$semesterId',
            options: Options(headers: {
              'Authorization': 'Bearer $loginToken',
            }));
    if (response.data['message'] == 'Successfully updated the course details') {
      List<Learning_content> data = [];
      CourseContentEntity d = CourseContentEntity.fromJsonMap(
        response.data,
      );
      data.addAll(d.academic_materials);
      data.addAll(d.learning_content);
      data.removeWhere(
          (element) => element.source == "");
      data.forEach((element) {
        log(element.source);
      });
      emit(
        CourseContentFetched(
          data,
          data,
        ),
      );
    } else {
      emit(
        CourseContentFailed(
          response.data['message'],
        ),
      );
    }
  }

  getFacultyAddedCourseContent(int unitId, int semesterId) async {
    emit(
      CourseContentInitial(),
    );
    final response = await EdwiselyApi.dio.get(
        'getFacultyAddedCourseContent?unit_id=$unitId&subject_semester_id=$semesterId',
        options: Options(headers: {
          'Authorization': 'Bearer $loginToken',
        }));
    if (response.data['message'] == 'Successfully updated the course details') {
      List<Learning_content> data = List<Learning_content>.from(
          response.data["data"].map((it) => Learning_content.fromJsonMap(it)));
      emit(
        CourseContentFetched(
          data,
          data,
        ),
      );
    } else {
      emit(
        CourseContentFailed(
          response.data['message'],
        ),
      );
    }
  }

  getFacultyBookmarkedCourseContent(int unitId, int semesterId) async {
    emit(
      CourseContentInitial(),
    );
    final response = await EdwiselyApi.dio.get(
        'getFacultyBookmarkedCourseContent?unit_id=$unitId&subject_semester_id=$semesterId',
        options: Options(headers: {
          'Authorization': 'Bearer $loginToken',
        }));
    if (response.data['message'] == 'Successfully updated the course details') {
      List<Learning_content> data = [];
      CourseContentEntity d = CourseContentEntity.fromJsonMap(
        response.data,
      );
      data.addAll(d.academic_materials);
      data.addAll(d.learning_content);
      emit(
        CourseContentFetched(
          data,
          data,
        ),
      );
    } else {
      emit(
        CourseContentFailed(
          response.data['message'],
        ),
      );
    }
  }

  getLevelWiseData(int level, List<Learning_content> data) {
    if (level == -1) {
      emit(
        CourseContentFetched(data, data),
      );
    } else {
      List<Learning_content> ddata = [];
      ddata.addAll(data);
      ddata.retainWhere((element) => element.level == level);
      emit(
        CourseContentFetched(ddata, data),
      );
    }
  }

  getDocumentWiseData(String doc, List<Learning_content> data) {
    if (doc == 'All') {
      emit(
        CourseContentFetched(data, data),
      );
    } else {
      List<Learning_content> ddata = [];
      ddata.addAll(data);
      ddata.retainWhere(
        (element) => element.type.toLowerCase().contains(
              doc.toLowerCase(),
            ),
      );
      ddata.forEach((element) {
        print(element.toJson());
      });
      emit(
        CourseContentFetched(ddata, data),
      );
    }
  }
}

@immutable
abstract class CourseContentState {}

class CourseContentInitial extends CourseContentState {}

class CourseContentFetched extends CourseContentState {
  final List<Learning_content> data;
  final List<Learning_content> backup;

  CourseContentFetched(this.data, this.backup);
}

class CourseContentFailed extends CourseContentState {
  final String error;

  CourseContentFailed(this.error);
}
