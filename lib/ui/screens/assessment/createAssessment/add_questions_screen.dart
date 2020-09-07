import 'package:edwisely/util/enums/question_type_enum.dart';
import 'package:flutter/material.dart';

class AddQuestionsScreen extends StatelessWidget {
  final String _title;
  final String _description;
  final int _subjectId;
  final QuestionType _questionType;

  AddQuestionsScreen(
      this._title, this._description, this._subjectId, this._questionType);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
