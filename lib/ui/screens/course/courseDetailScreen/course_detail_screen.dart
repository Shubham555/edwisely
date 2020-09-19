import 'package:edwisely/data/blocs/coursesBloc/courses_bloc.dart';
import 'package:edwisely/data/blocs/questionBank/questionBankObjective/question_bank_objective_bloc.dart';
import 'package:edwisely/data/blocs/questionBank/questionBankSubjective/question_bank_subjective_bloc.dart';
import 'package:edwisely/data/blocs/questionBank/question_bank_bloc.dart';
import 'package:edwisely/data/cubits/unit_cubit.dart';
import 'package:edwisely/ui/screens/course/courseDetailScreen/course_detail_about_tab.dart';
import 'package:edwisely/ui/screens/course/courseDetailScreen/course_detail_course_content_tab.dart';
import 'package:edwisely/ui/screens/course/courseDetailScreen/course_detail_question_bank_tab.dart';
import 'package:edwisely/ui/screens/course/courseDetailScreen/course_detail_syllabus_tab.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetailScreen extends StatefulWidget {
  final String _courseName;
  final int semesterSubjectId;

  CourseDetailScreen(this._courseName, this.semesterSubjectId);

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BigAppBar(
              actions: null,
              titleText: widget._courseName,
              bottomTab: TabBar(
                labelPadding: EdgeInsets.symmetric(horizontal: 30),
                indicatorColor: Colors.white,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                isScrollable: true,
                controller: _tabController,
                tabs: [
                  Tab(
                    text: 'About',
                  ),
                  Tab(
                    text: 'Syllabus',
                  ),
                  Tab(
                    text: 'Course Content',
                  ),
                  Tab(
                    text: 'Question Bank',
                  ),
                ],
              ),
              appBarSize: MediaQuery.of(context).size.height / 3,
              appBarTitle: Text(
                'Edwisely',
                style: TextStyle(color: Colors.black),
              ),
              flatButton: null)
          .build(context),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          BlocProvider(
            create: (BuildContext context) => CoursesBloc()
              ..add(
                GetCourse(
                  widget.semesterSubjectId,
                ),
              ),
            child: CourseDetailAboutTab(),
          ),
          BlocProvider(
            create: (BuildContext context) => CoursesBloc()
              ..add(
                GetCourseSyllabus(
                  widget.semesterSubjectId,
                ),
              ),
            child: CourseDetailSyllabusTab(),
          ),
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) => CoursesBloc()
                  ..add(
                    GetCourseContentData(
                      widget.semesterSubjectId,
                    ),
                  ),
              ),
              BlocProvider(
                create: (BuildContext context) => UnitCubit()
                  ..getUnitsOfACourse(
                    widget.semesterSubjectId,
                  ),
              ),
            ],
            child: CourseDetailCourseContentTab(),
          ),
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) => CoursesBloc()
                  ..add(
                    GetCourseContentData(
                      widget.semesterSubjectId,
                    ),
                  ),
              ),
              BlocProvider(
                create: (BuildContext context) => UnitCubit()
                  ..getUnitsOfACourse(
                    widget.semesterSubjectId,
                  ),
              ),
              BlocProvider(
                create: (BuildContext context) => QuestionBankBloc(),
              ),
              BlocProvider(
                create: (BuildContext context) => QuestionBankObjectiveBloc(),
              ),
              BlocProvider(
                create: (BuildContext context) => QuestionBankSubjectiveBloc(),
              ),
            ],
            child: CourseDetailQuestionBankTab(
              widget.semesterSubjectId,
            ),
          ),
        ],
      ),
    );
  }
}
