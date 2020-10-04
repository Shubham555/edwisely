import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/model/homeScreen/materialComment/MaterialComment.dart';
import 'package:meta/meta.dart';

class MaterialCommentCubit extends Cubit<MaterialCommentState> {
  MaterialCommentCubit() : super(MaterialCommentInitial());

  getComments(int materialId) async {
    final response = await EdwiselyApi.dio.post('Material/getComments');
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

  postComment(int materialId, String comment) async {
    final response = await EdwiselyApi.dio.post(
      'Material/Comment',
      data: FormData.fromMap(
        {
          'material_id': materialId,
          'comment': comment,
        },
      ),
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
abstract class MaterialCommentState {}

class MaterialCommentInitial extends MaterialCommentState {}

class MaterialCommentAdded extends MaterialCommentState {}

class MaterialCommentsFetched extends MaterialCommentState {
  final MaterialComment materialComment;

  MaterialCommentsFetched(this.materialComment);
}

class MaterialCommentFailed extends MaterialCommentState {
  final String error;

  MaterialCommentFailed(this.error);
}
