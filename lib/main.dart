import 'package:edwisely/util/theme.dart';
import 'package:flutter/material.dart';

import 'ui/screens/home_screen.dart';

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
      home: HomeScreen(),
      //   MultiBlocProvider(
      // providers: [
      //   BlocProvider(
      //     create: (BuildContext context) => SendAssessmentCubit(),
      //   )
      // ],
      // child: SendAssessmentScreen(2052, 'title', 'noOfQuestions'),
      // ),
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

// nerw todo
//todo add dept in  detail about
//todo reduce run and spacing in details syllabus
//todo make unit sup in question bank
//todo add time asloin the send asssessment
//todo add courses fix
//todo add dropdown for difficulty level in type ques
