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

void _initializeVariables() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    departmentId = int.parse(sharedPreferences.getString('department_id'));
    collegeId = int.parse(sharedPreferences.getString('college_id'));
    loginToken = sharedPreferences.getString('login_key').toString();
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
