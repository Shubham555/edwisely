import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:meta/meta.dart';

part 'add_question_event.dart';

part 'add_question_state.dart';

class AddQuestionBloc extends Bloc<AddQuestionEvent, AddQuestionState> {
  AddQuestionBloc() : super(AddQuestionInitial());

  @override
  Stream<AddQuestionState> mapEventToState(
    AddQuestionEvent event,
  ) async* {
    if (event is UploadExcel) {
      final response = await EdwiselyApi().dio().then((value) => value.post(
            'questionnaireWeb/uploadObjectiveQuestions',
            data: FormData.fromMap(
              {
                'files': MultipartFile.fromBytes(event.file.toUint8List(),
                    filename: event.file.fileName),
                'topics': [
                  {'id': 13779, 'type': 'sdvsd'},
                  {'id': 13780, 'type': 'sdvsd'},
                ]
              },
            ),
          ));
      print(response.data);
    }
  }
}
