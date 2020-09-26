import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:meta/meta.dart';

import '../api/api.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  sendNotification(
    String title,
    String description,
    int priority,
    int isCommentAnonymous,
    List<int> students,
    FilePickerCross file,
  ) async {
    final response = await EdwiselyApi.dio.post(
      'college/createNotification',
      data: FormData.fromMap(
        {
          'title': title,
          'description': description,
          'priority': priority,
          'is_comment_anonymous': isCommentAnonymous,
          'students': jsonEncode(students),
          'file': MultipartFile.fromBytes(
            file.toUint8List(),
            filename: file.fileName,
          ),
        },
      ),
    );
    if (response.data['message'] == 'Successfully created the notification') {
      emit(
        NotificationSent(),
      );
    } else {
      emit(
        NotificationSentFailed(),
      );
    }
  }
}

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationSent extends NotificationState {}

class NotificationSentFailed extends NotificationState {}
