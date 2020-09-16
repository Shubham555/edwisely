import 'package:edwisely/data/blocs/coursesBloc/courses_bloc.dart';
import 'package:edwisely/data/blocs/questionBank/questionBankObjective/question_bank_objective_bloc.dart';
import 'package:edwisely/data/blocs/questionBank/questionBankSubjective/question_bank_subjective_bloc.dart';
import 'package:edwisely/data/blocs/questionBank/question_bank_bloc.dart';
import 'package:edwisely/data/cubits/unit_cubit.dart';
import 'package:edwisely/ui/screens/course/courseDetailScreen/courseDetailQuestionBankTab/course_details_objective_part.dart';
import 'package:edwisely/ui/screens/course/courseDetailScreen/courseDetailQuestionBankTab/course_details_subjective_part.dart';
import 'package:edwisely/ui/screens/course/courseDetailScreen/courseDetailQuestionBankTab/question_bank_all_tab.dart';
import 'package:edwisely/ui/screens/course/courseDetailScreen/courseDetailQuestionBankTab/question_bank_objective_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'courseDetailQuestionBankTab/course_details_subjective_tab.dart';

class CourseDetailQuestionBankTab extends StatefulWidget {
  final subjectId;

  CourseDetailQuestionBankTab(this.subjectId);

  @override
  _CourseDetailQuestionBankTabState createState() =>
      _CourseDetailQuestionBankTabState();
}

class _CourseDetailQuestionBankTabState
    extends State<CourseDetailQuestionBankTab>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          labelPadding: EdgeInsets.symmetric(horizontal: 30),
          indicatorColor: Colors.white,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          isScrollable: true,
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                'All',
              ),
            ),
            Tab(
              child: Text(
                'Objective',
              ),
            ),
            Tab(
              child: Text(
                'Subjective',
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              BlocProvider.value(
                value: context.bloc<QuestionBankBloc>(),
                child: QuestionBankAllTab(widget.subjectId),
              ),
              BlocProvider.value(
                value: context.bloc<QuestionBankBloc>(),
                child: QuestionBankObjectiveTab(widget.subjectId),
              ),
              BlocProvider.value(
                value: context.bloc<QuestionBankBloc>(),
                child: QuestionBankSubjectiveTab(widget.subjectId),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
