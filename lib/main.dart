import 'package:edwisely/ui/screens/assessment/assessmentLandingScreen/assessment_landing_screen.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/add_questions_screen.dart';
import 'package:edwisely/ui/screens/course/courses_landing_screen.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';
import 'package:edwisely/util/theme.dart';
import 'package:flutter/material.dart';

import 'data/blocs/addQuestionScreen/add_question_bloc.dart';
import 'ui/screens/assessment/createAssessment/add_questions_screen.dart';

void main() {
  runApp(EdWisely());
}

class EdWisely extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edwisely',
      theme: EdwiselyTheme.themeDataEdwisely,
      debugShowCheckedModeBanner: false,
      home: AddQuestionsScreen(
        'T',
        'dfdf',
        10,
        QuestionType.Objective,
        2052,
      ),
    );
  }
}
