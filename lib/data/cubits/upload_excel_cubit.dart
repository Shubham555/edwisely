import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:meta/meta.dart';

import '../../main.dart';
import '../api/api.dart';

class UploadExcelCubit extends Cubit<UploadExcelState> {
  UploadExcelCubit() : super(UploadExcelInitial());

  uploadExcel(FilePickerCross file) async {
    final response =
        await EdwiselyApi.dio.post('questionnaireWeb/uploadObjectiveQuestions',
            data: FormData.fromMap(
              {
                'files': MultipartFile.fromBytes(file.toUint8List(),
                    filename: file.fileName),
                'topics': [
                  {'id': 13779, 'type': 'sdvsd'},
                  {'id': 13780, 'type': 'sdvsd'},
                ]
              },
            ),
            options: Options(headers: {
              'Authorization': 'Bearer $loginToken',
            }));
  }
}

@immutable
abstract class UploadExcelState {}

class UploadExcelInitial extends UploadExcelState {}
