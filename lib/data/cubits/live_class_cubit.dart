import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:meta/meta.dart';

class LiveClassCubit extends Cubit<LiveClassState> {
  LiveClassCubit() : super(LiveClassInitial());

  sendLiveClass(
    String title,
    String description,
    String startTime,
    List<int> students,
    String endTime,
  ) async {
    final response = await EdwiselyApi().dio().then(
          (value) => value.post(
            'college/createNotification',
            data: FormData.fromMap(
              {
                'title': title,
                'description': description,
                'start_time': startTime,
                'end_time': endTime,
                'students': jsonEncode(students),
              },
            ),
          ),
        );
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
