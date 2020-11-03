import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:meta/meta.dart';

import '../../main.dart';
import '../api/api.dart';

class AddFacultyContentCubit extends Cubit<AddFacultyContentState> {
  AddFacultyContentCubit() : super(AddFacultyContentInitial());

  addFacultyContent(
    int unitId,
    String topicCode,
    int materialType,
    String name,
    FilePickerCross attachments,
    String displayType,
    String externalUrl, //ik sec 10 lele
  ) async {
    final response = await EdwiselyApi.dio.post('addFacultyContent',
        data: FormData.fromMap(
          {
            'unit_id': unitId,
            'topic_code': topicCode,
            'material_type': materialType,
            'name': name,
            'attachments': attachments == null
                ? null
                : MultipartFile.fromBytes(
                    attachments.toUint8List(),
                    filename: attachments.fileName,
                  ),
            'display_type': displayType,
            'external_url': externalUrl
          },
        ),
        options: Options(headers: {
          'Authorization': 'Bearer $loginToken',
        }));

    if (response.data['message'] == 'Successfully updated the course details') {
      emit(
        AddFacultyContentAdded(),
      );
    } else {
      emit(
        AddFacultyContentFailed(
          response.data['message'],
        ),
      );
    }
  }

  updateFacultyContent(
    int topicId,
    int materialThype,
    int materialId,
    String name, {
    FilePickerCross attachments,
  }) async {
    final response = await EdwiselyApi.dio.post('units/updateMaterial',
        data: FormData.fromMap(
          {
            'topic_id': topicId,
            'material_type': materialThype,
            'material_id': materialId,
            'name': name,
            'attachements': MultipartFile.fromBytes(
              attachments.toUint8List(),
              filename: attachments.fileName,
            ),
          },
        ),
        options: Options(headers: {
          'Authorization': 'Bearer $loginToken',
        }));
    if (response.data['message'] == 'Successfully updated the course details') {
      emit(
        AddFacultyContentAdded(),
      );
    } else {
      emit(
        AddFacultyContentFailed(
          response.data['message'],
        ),
      );
    }
  }
}

@immutable
abstract class AddFacultyContentState {}

class AddFacultyContentInitial extends AddFacultyContentState {}

class AddFacultyContentAdded extends AddFacultyContentState {}

class AddFacultyContentFailed extends AddFacultyContentState {
  final String error;

  AddFacultyContentFailed(this.error);
}
