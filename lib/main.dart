import 'package:edwisely/ui/screens/course/courses_landing_screen.dart';
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
        home: CoursesLandingScreen()
        // BlocProvider(
        //   create: (BuildContext context) => CoursesBloc(),
        //   child: AddCourseScreen(),
        // ),
        //   AddQuestionsScreen(
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
//todo syllabus under details has now topic names
//todo add latex rendering in question bank and all where question is written or viewed
//todo add filter by departments in add courses
//todo change drop_downSearch
