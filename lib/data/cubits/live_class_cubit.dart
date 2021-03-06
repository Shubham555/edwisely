import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../main.dart';
import '../api/api.dart';

class LiveClassCubit extends Cubit<LiveClassState> {
  LiveClassCubit() : super(LiveClassInitial());

  sendLiveClass(
    String title,
    String description,
    String startTime,
    List<int> students,
    String endTime,
  ) async {
    final response = await EdwiselyApi.dio.post('college/createVC',
        data: FormData.fromMap(
          {
            'title': title,
            'description': description,
            'start_time': startTime,
            'end_time': endTime,
            'students': jsonEncode(students),
          },
        ),
        options: Options(headers: {
          'Authorization': 'Bearer $loginToken',
        }));
    if (response.data['message'] ==
        'Successfully created the video conference') {
      emit(
        LiveClassSent(),
      );
    } else {
      emit(
        LiveClassSendFailed(),
      );
    }
  }
}

@immutable
abstract class LiveClassState {}

class LiveClassInitial extends LiveClassState {}

class LiveClassSent extends LiveClassState {}

class LiveClassSendFailed extends LiveClassState {}
