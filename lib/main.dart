import 'package:edwisely/models/question.dart';
import 'package:edwisely/models/questionType.dart';
import 'package:edwisely/pages/assessmentPage.dart';
import 'package:edwisely/pages/dashboard.dart';
import 'package:edwisely/swatches/themes.dart';
import 'package:flutter/material.dart';

import 'models/assessment.dart';

void main() => runApp(Edwisely());

class Edwisely extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.peacock,
      home: AssessmentPage(
        assessment: Assessment(
          deadline: null,
          description: 'Sample quiz',
          duration: 200,
          questions: [
            Question(
                answers: null,
                question: 'Who is the president of the United States',
                rightAnswer: null,
                type: QuestionType.Objective,
                points: null)
          ],
          title: 'Sample quiz',
        ),
      ),
    );
  }
}
