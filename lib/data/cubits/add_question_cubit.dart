import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:meta/meta.dart';

import '../api/api.dart';

class AddQuestionCubit extends Cubit<AddQuestionState> {
  AddQuestionCubit() : super(AddQuestionInitial());

  addQuestion(
      String question,
      List<Map> topics,
      List<String> options,
      int bloomsLevel,
      int difficultyLevel,
      String source,
      String type,
      int fieldType,
      int answer,
      FilePickerCross option1,
      FilePickerCross option2,
      FilePickerCross option3,
      FilePickerCross option4,
      FilePickerCross option5,
      FilePickerCross questionImage,
      int assessmentId,
      List<int> questions,
      String hint,
      String solution,
      bool isFromQuestionBank

      // FilePickerCross solutionImage,
      ) async {
    final response = await EdwiselyApi.dio.post(
      'questionnaireWeb/addObjectiveQuestion',
      data: FormData.fromMap(
        {
          'question': question,
          'topics': jsonEncode(topics),
          'options': jsonEncode(options),
          'blooms_level': bloomsLevel,
          'difficulty_level': difficultyLevel,
          'source': source,
          'type': type,
          //mcq
          'field_type': 1,
          'answer': answer,
          'question_img': questionImage == null ? null : MultipartFile.fromBytes(questionImage.toUint8List(), filename: questionImage.fileName),
          // 'solution_img': MultipartFile.fromBytes(solutionImage.toUint8List(),
          //     filename: solutionImage.fileName),
          'option1_img': option1 == null ? null : MultipartFile.fromBytes(option1.toUint8List(), filename: option1.fileName),
          'option2_img': option2 == null ? null : MultipartFile.fromBytes(option2.toUint8List(), filename: option2.fileName),
          'option3_img': option3 == null ? null : MultipartFile.fromBytes(option3.toUint8List(), filename: option3.fileName),
          'option4_img': option4 == null ? null : MultipartFile.fromBytes(option4.toUint8List(), filename: option4.fileName),
          'option5_img': option5 == null ? null : MultipartFile.fromBytes(option5.toUint8List(), filename: option5.fileName),
          'hint': hint,
          'solution': solution
        },
      ),
    );
    if (response.data['message'] == 'Successfully updated the questions') {
      if (isFromQuestionBank) {
        emit(
          QuestionAdded(),
        );
      } else {
        questions.add(response.data['data']['id']);
        final rresponse = await EdwiselyApi.dio.post(
          'questionnaireWeb/editObjectiveTestQuestions',
          data: FormData.fromMap(
            {
              'test_id': assessmentId,
              'questions': jsonEncode(questions),
              'units': jsonEncode([]),
            },
          ),
        );
        if (rresponse.statusCode == 200) {
          emit(
            QuestionAdded(),
          );
        }
      }
    } else {
      emit(
        QuestionAddFailed(),
      );
    }
  }
}

@immutable
abstract class AddQuestionState {}

class AddQuestionInitial extends AddQuestionState {}

class QuestionAdded extends AddQuestionState {}

class QuestionAddFailed extends AddQuestionState {}
