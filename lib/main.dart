import 'package:edwisely/ui/screens/assessment/sendAssessment/send_assessment_screen.dart';
import 'package:edwisely/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/cubits/send_assessment_cubit.dart';

import 'ui/screens/authorization/login_screen.dart';

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
      home:
          // CoursesLandingScreen()
          MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => SendAssessmentCubit(),
          )
        ],
        child: SendAssessmentScreen(2052, 'title', 'noOfQuestions'),
      ),
      // AddQuestionsScreen(
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
