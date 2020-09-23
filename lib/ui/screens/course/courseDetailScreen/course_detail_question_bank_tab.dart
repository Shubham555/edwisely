import 'package:edwisely/data/blocs/questionBank/questionBankObjective/question_bank_objective_bloc.dart';
import 'package:edwisely/data/blocs/questionBank/questionBankSubjective/question_bank_subjective_bloc.dart';
import 'package:edwisely/data/blocs/questionBank/question_bank_bloc.dart';
import 'package:edwisely/data/cubits/unit_cubit.dart';
import 'package:edwisely/ui/screens/course/courseDetailScreen/courseDetailQuestionBankTab/question_bank_all_tab.dart';
import 'package:edwisely/ui/screens/course/courseDetailScreen/courseDetailQuestionBankTab/question_bank_objective_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../util/theme.dart';
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
                        title: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color:
                                enabledUnitId == state.units.data[index].id
                                    ? Theme.of(context).primaryColor
                                    : Colors.transparent,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: enabledUnitId ==
                                        state.units.data[index].id
                                    ? 6.0
                                    : 0,
                                color: enabledUnitId ==
                                        state.units.data[index].id
                                    ? Colors.black.withOpacity(0.3)
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                          child: Text(
                            state.units.data[index].name,
                            style: TextStyle(
                              color: enabledUnitId ==
                                      state.units.data[index].id
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                              fontSize: enabledUnitId ==
                                      state.units.data[index].id
                                  ? 25
                                  : null,
                            ),
                          ),
                        ),
                        onTap: () {
                          enabledUnitId = state.units.data[index].id;
                          setState(
                            () {},
                          );
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
                      ),
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
                indicatorColor: EdwiselyTheme.PRIMARY_COLOR,
                labelColor: Colors.white,
                indicator: BoxDecoration(
                  color: EdwiselyTheme.PRIMARY_COLOR,
                ),
                indicatorPadding: const EdgeInsets.only(top: 8.0),
                unselectedLabelColor: EdwiselyTheme.PRIMARY_COLOR,
                unselectedLabelStyle: Theme.of(context).textTheme.headline6,
                labelStyle: Theme.of(context).textTheme.headline5,
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
    );
  }
}
