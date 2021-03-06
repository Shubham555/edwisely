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
  final subjectsubjectId;

  CourseDetailQuestionBankTab(this.subjectId, this.subjectsubjectId);

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
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: MediaQuery.of(context).size.width / 6,
            child: BlocBuilder(
              cubit: context.bloc<UnitCubit>()
                ..getUnitsOfACourse(widget.subjectId),
              builder: (BuildContext context, state) {
                if (state is CourseUnitFetched) {
                  _tabController.index == 0
                      ? context.bloc<QuestionBankObjectiveBloc>().add(
                            GetUnitObjectiveQuestions(
                              widget.subjectsubjectId,
                              state.units.data[0].id,
                            ),
                          )
                      : null;
                  _tabController.addListener(
                    () {
                      switch (_tabController.index) {
                        case 0:
                          context.bloc<QuestionBankObjectiveBloc>().add(
                                GetUnitObjectiveQuestions(
                                  widget.subjectId,
                                  state.units.data[0].id,
                                ),
                              );
                          break;
                        case 1:
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
                  int enabledUnitId = state.units.data[0].id;

                  return StatefulBuilder(
                    builder: (BuildContext context,
                        void Function(void Function()) setState) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.units.data.length,
                        itemBuilder: (BuildContext context, int index) =>
                            ListTile(
                          hoverColor: Colors.white,
                          selected: enabledUnitId == state.units.data[index].id,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.units.data[index].name,
                                style: TextStyle(
                                    color: enabledUnitId ==
                                            state.units.data[index].id
                                        ? Colors.black
                                        : Colors.grey.shade600,
                                    fontSize: enabledUnitId ==
                                            state.units.data[index].id
                                        ? 25
                                        : null),
                              ),
                            ],
                          ),
                          onTap: () {
                            enabledUnitId = state.units.data[index].id;

                            setState(
                              () {},
                            );
                            switch (_tabController.index) {
                              case 0:
                                context.bloc<QuestionBankObjectiveBloc>().add(
                                      GetUnitObjectiveQuestions(
                                        widget.subjectId,
                                        state.units.data[index].id,
                                      ),
                                    );
                                break;
                              case 1:
                                context.bloc<QuestionBankSubjectiveBloc>().add(
                                      GetUnitSubjectiveQuestions(
                                        widget.subjectId,
                                        state.units.data[index].id,
                                      ),
                                    );
                                break;
                            }
                          },
                        ),
                      );
                    },
                  );
                }
                if (state is CourseUnitEmpty) {
                  return Center(child: Text('No Data'));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
        Expanded(
          child: Column(
            children: [
              Align(
                child: TabBar(
                  labelPadding: EdgeInsets.symmetric(horizontal: 30),
                  indicatorColor: Colors.white,
                  labelColor: Colors.black,
                  physics: NeverScrollableScrollPhysics(),
                  unselectedLabelColor: Colors.grey,
                  unselectedLabelStyle:
                      TextStyle(fontWeight: FontWeight.normal),
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  isScrollable: true,
                  controller: _tabController,
                  tabs: [
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
                alignment: Alignment.topLeft,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    BlocProvider.value(
                      value: context.bloc<QuestionBankBloc>(),
                      child: QuestionBankObjectiveTab(
                          widget.subjectId, widget.subjectsubjectId),
                    ),
                    BlocProvider.value(
                      value: context.bloc<QuestionBankBloc>(),
                      child: QuestionBankSubjectiveTab(
                        widget.subjectId,
                          widget.subjectsubjectId
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
