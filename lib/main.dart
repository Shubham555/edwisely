

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
