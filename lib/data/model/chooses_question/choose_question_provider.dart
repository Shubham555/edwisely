import 'package:flutter/material.dart';

class ChooseQuestionProvider extends ChangeNotifier {
  String question;
  List<String> options;
  int bloomsLevel;
  int difficultyLevel;
  String solution;
  String hint;
  String answer;
}
