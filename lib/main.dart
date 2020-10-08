import 'package:edwisely/data/cubits/get_units_cubit.dart';
import 'package:edwisely/data/cubits/home_screen_default_cubit.dart';
import 'package:edwisely/data/cubits/material_comment_cubit.dart';
import 'package:edwisely/data/cubits/opic_questions_cubit.dart';
import 'package:edwisely/ui/screens/assessment/sendAssessment/send_assessment_screen.dart';
import 'package:edwisely/util/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './data/provider/selected_page.dart';
import 'data/blocs/conductdBloc/conducted_bloc.dart';
import 'data/blocs/coursesBloc/courses_bloc.dart';
import 'data/blocs/objectiveBloc/objective_bloc.dart';
import 'data/blocs/questionBank/questionBankObjective/question_bank_objective_bloc.dart';
import 'data/blocs/questionBank/questionBankSubjective/question_bank_subjective_bloc.dart';
import 'data/blocs/questionBank/question_bank_bloc.dart';
import 'data/blocs/subjectiveBloc/subjective_bloc.dart';
import 'data/cubits/add_course_cubit.dart';
import 'data/cubits/add_faculty_content_cubit.dart';
import 'data/cubits/add_question_cubit.dart';
import 'data/cubits/course_content_cubit.dart';
import 'data/cubits/deck_items_cubit.dart';
import 'data/cubits/department_cubit.dart';
import 'data/cubits/get_course_decks_cubit.dart';
import 'data/cubits/live_class_cubit.dart';
import 'data/cubits/login_cubit.dart';
import 'data/cubits/notification_cubit.dart';
import 'data/cubits/objective_questions_cubit.dart';
import 'data/cubits/question_add_cubit.dart';
import 'data/cubits/select_students_cubit.dart';
import 'data/cubits/send_assessment_cubit.dart';
import 'data/cubits/topic_cubit.dart';
import 'data/cubits/unit_cubit.dart';
import 'data/cubits/unit_topic_cubit.dart';
import 'data/cubits/upload_excel_cubit.dart';
import 'data/provider/selected_page.dart';
import 'util/theme.dart';

int departmentId;
int collegeId;
String loginToken;

main() {
  _initializeVariables();
  runApp(EdWisely());
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

void _initializeVariables() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // departmentId = sharedPreferences.getString('department_id');
  // collegeId = sharedPreferences.getString('college_id');
  // loginToken = sharedPreferences.getString('login_token');
  departmentId = 71;
  collegeId = 102;
  loginToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMTMwLCJlbWFpbCI6InByYWthc2hAZWR3aXNlbHkuY29tIiwiaW5pIjoiMTYwMTg5MDI3NiIsImV4cCI6IjE2MDMxODYyNzYifQ.myMJblQ-sLqMxlLREs2I4TqkHsECGnTJ6X_4eGFKa0Q';
}

class EdWisely extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SelectedPageProvider(navigatorKey),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => UploadExcelCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => CourseContentCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => ConductedBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => CoursesBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => ObjectiveBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => QuestionBankObjectiveBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => QuestionBankSubjectiveBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => QuestionBankBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => SubjectiveBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => AddQuestionCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => QuestionsCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => SelectStudentsCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => SendAssessmentCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => TopicCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => UnitCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => LoginCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => QuestionAddCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => AddCourseCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => CourseDecksCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => DepartmentCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => AddFacultyContentCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => NotificationCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => LiveClassCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => TopicQuestionsCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => UnitTopicCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => StudentsCountCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => DeckItemsCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => GetUnitsCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => HomeScreenDefaultCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => CommentCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'Edwisely',
          theme: EdwiselyTheme.themeDataEdwisely,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: MyRouter.onGenerateRoute,
          navigatorKey: navigatorKey,
          // home: LoginScreen(),
          // home: AddQuestionsScreen(
          //   'T',
          //   'dfdf',
          //   352,
          //   QuestionType.Objective,
          //   2052,
          // ),
        ),
      ),
    );
  }
}
//todo add latex rendering in question bank and all where question is written or viewed
//todo password and confirm password for login
// TODO: 10/5/2020 add courses department filter sahi krna hai
// FIXME: 10/5/2020 add question blooms filter
// FIXME: 10/5/2020 upload excel tab
// TODO: 10/5/2020 comments and apis
// TODO: 10/5/2020 make topics and sub topics as one
// TODO: 10/8/2020 add correct answer
