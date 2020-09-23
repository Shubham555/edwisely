import 'package:edwisely/data/blocs/addQuestionScreen/add_question_bloc.dart';
import 'package:edwisely/data/blocs/conductdBloc/conducted_bloc.dart';
import 'package:edwisely/data/blocs/coursesBloc/courses_bloc.dart';
import 'package:edwisely/data/blocs/questionBank/questionBankObjective/question_bank_objective_bloc.dart';
import 'package:edwisely/data/blocs/questionBank/questionBankSubjective/question_bank_subjective_bloc.dart';
import 'package:edwisely/data/blocs/questionBank/question_bank_bloc.dart';
import 'package:edwisely/data/blocs/subjectiveBloc/subjective_bloc.dart';
import 'package:edwisely/data/cubits/add_course_cubit.dart';
import 'package:edwisely/data/cubits/add_question_cubit.dart';
import 'package:edwisely/data/cubits/login_cubit.dart';
import 'package:edwisely/data/cubits/objective_questions_cubit.dart';
import 'package:edwisely/data/cubits/question_add_cubit.dart';
import 'package:edwisely/data/cubits/select_students_cubit.dart';
import 'package:edwisely/data/cubits/send_assessment_cubit.dart';
import 'package:edwisely/data/cubits/topic_cubit.dart';
import 'package:edwisely/data/cubits/unit_cubit.dart';
import 'package:edwisely/data/cubits/upload_excel_cubit.dart';
import 'package:edwisely/data/provider/selected_page.dart';
import 'package:edwisely/ui/screens/course/courses_landing_screen.dart';
import 'package:edwisely/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'data/blocs/objectiveBloc/objective_bloc.dart';
import 'ui/screens/course/courses_landing_screen.dart';
import 'data/cubits/course_content_cubit.dart';

void main() {
  runApp(EdWisely());
}

class EdWisely extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SelectedPageProvider(),
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
        ],
        child: MaterialApp(
          title: 'Edwisely',
          theme: EdwiselyTheme.themeDataEdwisely,
          debugShowCheckedModeBanner: false,
          home: CoursesLandingScreen(),
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
          //   352,
          //   QuestionType.Objective,
          //   2154,
          // ),
        ),
      ),
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
//units passed empty

//23/09/2020
//todo ask about unidepid

//news

//todo password and confirm poassword for login
//todo add button to right bottom right
//todo check for apifrom backend for select from existing
//todo reduce
