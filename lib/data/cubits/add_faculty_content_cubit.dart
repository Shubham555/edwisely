import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:meta/meta.dart';

class AddFacultyContentCubit extends Cubit<AddFacultyContentState> {
  AddFacultyContentCubit() : super(AddFacultyContentInitial());

  addFacultyContent(
      int unitId, String topicCode, int materialType, String name, FilePickerCross attachments, String displayType, String externalUrl) async {
    final response = await EdwiselyApi().dio().then(
          (value) => value.post(
            'addFacultyContent',
            data: FormData.fromMap(
              {
                'unit_id': unitId,
                'topic_code': topicCode,
                'material_type': materialType,
                'name': name,
                'attachments': MultipartFile.fromBytes(
                  attachments.toUint8List(),
                  filename: attachments.fileName,
                ),
                'display_type': displayType,
                'external_url': externalUrl
              },
            ),
          ),
        );
    print(response.data);
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
