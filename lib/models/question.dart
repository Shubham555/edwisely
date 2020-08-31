//Question data model class

import 'package:edwisely/models/questionType.dart';
import 'package:flutter/foundation.dart'; //Import needed for the @required parameters

class Question {
  String question;
  List<String> answers;
  int rightAnswer; // Integer representing the index of the right answer
  int points;
  QuestionType type;

  Question({
    @required this.answers,
    @required this.question,
    @required this.rightAnswer,
    @required this.type,
    @required this.points,
  });
}
