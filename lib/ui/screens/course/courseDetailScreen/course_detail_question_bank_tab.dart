import 'package:edwisely/data/blocs/questionBank/questionBankObjective/question_bank_objective_bloc.dart';
import 'package:edwisely/data/blocs/questionBank/questionBankSubjective/question_bank_subjective_bloc.dart';
import 'package:edwisely/data/blocs/questionBank/question_bank_bloc.dart';
import 'package:edwisely/data/cubits/unit_cubit.dart';
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
  int unitSeleceted;

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
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            // width: MediaQuery.of(context).size.width / 10,
            child: BlocBuilder(
              cubit: context.bloc<UnitCubit>()
                ..getUnitsOfACourse(widget.subjectId),
              builder: (BuildContext context, state) {
                if (state is CourseUnitFetched) {
                  _tabController.index == 0
                      ? context.bloc<QuestionBankBloc>().add(
                            GetUnitQuestions(
                              widget.subjectId,
                              state.units.data[0].id,
                            ),
                          )
                      : null;
                  _tabController.addListener(
                    () {
                      switch (_tabController.index) {
                        case 0:
                          context.bloc<QuestionBankBloc>().add(
                                GetUnitQuestions(
                                  widget.subjectId,
                                  state.units.data[0].id,
                                ),
                              );
                          break;
                        case 1:
                          context.bloc<QuestionBankObjectiveBloc>().add(
                                GetUnitObjectiveQuestions(
                                  widget.subjectId,
                                  state.units.data[0].id,
                                ),
                              );
                          break;
                        case 2:
                          context.bloc<QuestionBankSubjectiveBloc>().add(
                                GetUnitSubjectiveQuestions(
                                  widget.subjectId,
                                  state.units.data[0].id,
                                ),
                              );
                          break;
                      }
                    },
                  );
                  unitSeleceted = state.units.data[0].id;
                  return StatefulBuilder(
                    builder: (BuildContext context,
                        void Function(void Function()) setState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 13,
                          ),
                          Text('Units'),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.07,
                            padding: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 12.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(color: Colors.black),
                            ),
                            child: DropdownButton(
                              underline: SizedBox.shrink(),
                              isExpanded: true,
                              value: unitSeleceted,
                              items: List.generate(
                                state.units.data.length,
                                (index) => DropdownMenuItem(
                                  child: Text(state.units.data[index].name),
                                  value: state.units.data[index].id,
                                ),
                              ),
                              onChanged: (value) {
                                unitSeleceted = value;
                                switch (_tabController.index) {
                                  case 0:
                                    context.bloc<QuestionBankBloc>().add(
                                          GetUnitQuestions(
                                            widget.subjectId,
                                            value,
                                          ),
                                        );
                                    break;
                                  case 1:
                                    context
                                        .bloc<QuestionBankObjectiveBloc>()
                                        .add(
                                          GetUnitObjectiveQuestions(
                                            widget.subjectId,
                                            value,
                                          ),
                                        );
                                    break;
                                  case 2:
                                    context
                                        .bloc<QuestionBankSubjectiveBloc>()
                                        .add(
                                          GetUnitSubjectiveQuestions(
                                            widget.subjectId,
                                            value,
                                          ),
                                        );
                                    break;
                                }
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  labelPadding: EdgeInsets.symmetric(horizontal: 36.0),
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  indicatorPadding: const EdgeInsets.only(top: 8.0),
                  unselectedLabelColor: Colors.grey,
                  unselectedLabelStyle: Theme.of(context).textTheme.headline6,
                  labelStyle: Theme.of(context).textTheme.headline5.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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
                        child: QuestionBankAllTab(
                          widget.subjectId,
                          _tabController,
                        ),
                      ),
                      BlocProvider.value(
                        value: context.bloc<QuestionBankBloc>(),
                        child: QuestionBankObjectiveTab(
                          widget.subjectId,
                        ),
                      ),
                      BlocProvider.value(
                        value: context.bloc<QuestionBankBloc>(),
                        child: QuestionBankSubjectiveTab(
                          widget.subjectId,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
