import 'package:edwisely/ui/screens/assessment/assessmentLandingScreen/assessment_landing_screen.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/add_questions_screen.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';
import 'package:edwisely/util/theme.dart';
import 'package:flutter/material.dart';

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
        'dfvdf',
        10,
        QuestionType.Objective,
        2052,
      ),
    );
  }
}
