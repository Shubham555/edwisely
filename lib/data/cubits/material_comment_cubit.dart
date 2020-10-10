import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/homeScreen/materialComment/MaterialComment.dart';
import 'package:meta/meta.dart';

import '../../main.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(MaterialCommentInitial());

  getMaterialComments(int materialId) async {
    final response = await EdwiselyApi.dio
        .post('Material/getComments', data: FormData.fromMap({'material_id': materialId}), options: Options(
        headers: {
          'Authorization': 'Bearer $loginToken',
        }),);
    if (response.data['message'] == 'Successfully fetched comments') {
      emit(
        MaterialCommentsFetched(
          MaterialComment.fromJsonMap(
            response.data,
          ),
        ),
      );
    } else {
      emit(
        MaterialCommentFailed(
          response.data['message'],
        ),
      );
    }
  }

  postMaterialComment(int materialId, String comment) async {
    final response = await EdwiselyApi.dio.post(
      'Material/Comment',
      data: FormData.fromMap(
        {
          'material_id': materialId,
          'comment': comment,
        },
      ), options: Options(
        headers: {
          'Authorization': 'Bearer $loginToken',
        })
    );
    if (response.data['message'] == 'Successfully added material') {
      emit(
        MaterialCommentAdded(),
      );
    } else {
      emit(
        MaterialCommentFailed(
          response.data['message'],
        ),
      );
    }
  }

  getNotificationComments(int notificationId) async {
    final response = await EdwiselyApi.dio.post('Notification/getComments',
        data: FormData.fromMap({'notification_id': notificationId}), options: Options(
            headers: {
              'Authorization': 'Bearer $loginToken',
            }));
    if (response.data['message'] == 'Successfully fetched comments') {
      emit(
        MaterialCommentsFetched(
          MaterialComment.fromJsonMap(
            response.data,
          ),
        ),
      );
    } else {
      emit(
        MaterialCommentFailed(
          response.data['message'],
        ),
      );
    }
  }

  postNotificationComment(int notificationId, String comment) async {
    final response = await EdwiselyApi.dio.post(
      'Notification/Comment',
      data: FormData.fromMap(
        {
          'notification_id': notificationId,
          'comment': comment,
        },
      ), options: Options(
        headers: {
          'Authorization': 'Bearer $loginToken',
        })
    );
    if (response.data['message'] == 'Successfully added material') {
      emit(
        MaterialCommentAdded(),
      );
    } else {
      emit(
        MaterialCommentFailed(
          response.data['message'],
        ),
      );
    }
  }

  getSurveyComments(int surveyId) async {
    final response = await EdwiselyApi.dio
        .post('survey/getComments', data: FormData.fromMap({'survey_id': surveyId}), options: Options(
        headers: {
          'Authorization': 'Bearer $loginToken',
        }));
    if (response.data['message'] == 'Successfully fetched comments') {
      emit(
        MaterialCommentsFetched(
          MaterialComment.fromJsonMap(
            response.data,
          ),
        ),
      );
    } else {
      emit(
        MaterialCommentFailed(
          response.data['message'],
        ),
      );
    }
  }

  postSurveyComment(int surveyId, String comment) async {
    final response = await EdwiselyApi.dio.post(
      'survey/Comment',
      data: FormData.fromMap(
        {
          'survey_id': surveyId,
          'comment': comment,
        },
      ), options: Options(
        headers: {
          'Authorization': 'Bearer $loginToken',
        })
    );
    if (response.data['message'] == 'Successfully added material') {
      emit(
        MaterialCommentAdded(),
      );
    } else {
      emit(
        MaterialCommentFailed(
          response.data['message'],
        ),
      );
    }
  }
}

@immutable
abstract class CommentState {}

class MaterialCommentInitial extends CommentState {}

class MaterialCommentAdded extends CommentState {}

class MaterialCommentsFetched extends CommentState {
  final MaterialComment materialComment;

  MaterialCommentsFetched(this.materialComment);
}

class MaterialCommentFailed extends CommentState {
  final String error;

  MaterialCommentFailed(this.error);
}
