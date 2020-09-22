import 'package:edwisely/ui/screens/assessment/assessmentLandingScreen/assessment_landing_screen.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/add_questions_screen.dart';
import 'package:edwisely/ui/screens/course/courses_landing_screen.dart';
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
      home: AssessmentLandingScreen()
          //   MultiBlocProvider(
          // providers: [
          //   BlocProvider(
          //     create: (BuildContext context) => SendAssessmentCubit(),
          //   )
          // ],
          // child: SendAssessmentScreen(2052, 'title', 'noOfQuestions'),
          // ),
      //     AddQuestionsScreen(
      //   'T',
      //   'dfdf',
      //   10,
      //   QuestionType.Objective,
      //   2052,
      // ),
    );
  }
}
//todo question bank empty check
//todo add latex rendering in question bank and all where question is written or viewed
//todo add filter by departments in add courses

// new todo
//todo add dept in detail about //
//todo reduce run and spacing in details syllabus //
//todo make unit up in question bank //
//todo add time also in the send assessment
//todo add courses fix //
//todo add dropdown for difficulty level in type ques //


//api todo
//todo add quetion to assessment units context
