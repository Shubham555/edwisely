import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import './data/provider/selected_page.dart';
import './util/router.dart';
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
import 'data/cubits/upload_excel_cubit.dart';
import 'data/provider/selected_page.dart';
import 'util/theme.dart';

void main() {
  runApp(EdWisely());
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
        ],
        child: MaterialApp(
          title: 'Edwisely',
          theme: EdwiselyTheme.themeDataEdwisely,
          debugShowCheckedModeBanner: false,
          // home: CourseDetailScreen('', 352),
          onGenerateRoute: MyRouter.onGenerateRoute,
          navigatorKey: navigatorKey,
        ),
      ),
    );
  }
}
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
//units passed empty

//23/09/2020
//todo ask about unidepid

//news

//todo password and confirm poassword for login
//todo add button to right bottom right
//todo check for apifrom backend for select from existing

//25/09/2020 todos
//todo ask about where to put the update faculty added objective question type
// To change the type of faculty added objective question from public to private or vice versa  - type values that are accepted - [‘public’, ‘private’]
// update faculty added subjective question type
// To change the type of faculty added subjective question from public to private or vice versa  - type values that are accepted - [‘public’, ‘private’]
//todo ask about material_type
//todo tell to do either docs or doc
