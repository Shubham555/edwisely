import 'dart:async';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';
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
      final response = await EdwiselyApi.dio.post(
        'questionnaireWeb/uploadObjectiveQuestions',
        data: FormData.fromMap(
          {'files': event.file, 'topics': ''},
        ),
      );
      print(response.data);
    }
  }
}
