// Feel free to reach out to me anytime for doubts :)
// Been an awesome experience working on this project
// Signing off - Vis

import 'package:edwisely/models/question.dart';
import 'package:edwisely/models/questionType.dart';
import 'package:edwisely/pages/assessmentPage.dart';
import 'package:edwisely/swatches/themes.dart';
import 'package:edwisely/widgets/assessment/assessment_landing_page.dart';
import 'package:flutter/material.dart';

import 'models/assessment.dart';

void main() => runApp(Edwisely());

class Edwisely extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.peacock,
      // Assessment model containing dummy data
      //Reset home page when the design is done
      home: AssessmentLandingPage()
      // AssessmentPage(
      //   assessment: Assessment(
      //     deadline: null,
      //     description: 'Sample quiz',
      //     duration: 200,
      //     questions: [
      //       Question(
      //           answers: null,
      //           question: 'Who is the president of the United States',
      //           rightAnswer: null,
      //           type: QuestionType.Objective,
      //           points: null)
      //     ],
      //     title: 'Sample quiz',
      //     type: QuestionType
      //         .Objective, //TODO: Make it so that user can select this at the beginning of assessment creation
      //   ),
      // ),
    );
  }
}
