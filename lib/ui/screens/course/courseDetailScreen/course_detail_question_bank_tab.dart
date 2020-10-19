import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/blocs/questionBank/questionBankObjective/question_bank_objective_bloc.dart';
import '../../../../data/blocs/questionBank/questionBankSubjective/question_bank_subjective_bloc.dart';
import '../../../../data/blocs/questionBank/question_bank_bloc.dart';
import '../../../../data/cubits/unit_cubit.dart';
import 'courseDetailQuestionBankTab/course_details_subjective_tab.dart';
import 'courseDetailQuestionBankTab/question_bank_objective_tab.dart';

class CourseDetailQuestionBankTab extends StatefulWidget {
  final subjectId;

  CourseDetailQuestionBankTab(this.subjectId);

  @override
  _CourseDetailQuestionBankTabState createState() => _CourseDetailQuestionBankTabState();
}

class _CourseDetailQuestionBankTabState extends State<CourseDetailQuestionBankTab>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  int unitSelected;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
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
            width: MediaQuery.of(context).size.width / 10,
            child: BlocBuilder(
              cubit: context.bloc<UnitCubit>()..getUnitsOfACourse(widget.subjectId),
              builder: (BuildContext context, state) {
                if (state is CourseUnitFetched) {
                  _tabController.index == 0
                      ? context.bloc<QuestionBankObjectiveBloc>().add(
                            GetUnitObjectiveQuestions(
                              widget.subjectId,
                              state.units.data[0].id,
                            ),
                          )
                      : null;
                  _tabController.addListener(
                    () {
                      switch (_tabController.index) {
                        // case 0:
                        //   context.bloc<QuestionBankObjectiveBloc>().add(
                        //         GetUnitObjectiveQuestions(
                        //           widget.subjectId,
                        //           state.units.data[0].id,
                        //         ),
                        //       );
                        //   break;
                        case 1:
                          context.bloc<QuestionBankSubjectiveBloc>().add(
                                GetUnitSubjectiveQuestions(
                                  widget.subjectId,
                                  state.units.data[0].id,
                                ),
                              );
                          break;
                      }
                      setState(() {});
                    },
                  );
                  int enabledUnitId = state.units.data[0].id;

                  return StatefulBuilder(
                    builder: (BuildContext context, void Function(void Function()) setState) {
                      return Container(
                        margin: const EdgeInsets.only(right: 22.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                          ),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.units.data.length,
                          itemBuilder: (BuildContext context, int index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            child: InkWell(
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AnimatedDefaultTextStyle(
                                    duration: Duration(milliseconds: 300),
                                    style: enabledUnitId == state.units.data[index].id
                                        ? TextStyle(
                                            color: Colors.black,
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                          )
                                        : TextStyle(
                                            color: Colors.grey,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    child: Text(
                                      state.units.data[index].name,
                                    ),
                                  ),
                                  SizedBox(height: 2.0),
                                  AnimatedContainer(
                                    duration: Duration(
                                      milliseconds: 300,
                                    ),
                                    width: enabledUnitId == state.units.data[index].id ? 80.0 : 40.0,
                                    height: 3.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //     ListTile(
                          //   hoverColor: Colors.white,
                          //   selected: enabledUnitId == state.units.data[index].id,
                          //   title: Container(
                          //     padding: const EdgeInsets.symmetric(
                          //       vertical: 8.0,
                          //     ),
                          //     alignment: Alignment.center,
                          //     child: Text(
                          //       state.units.data[index].name,
                          //       style: enabledUnitId == state.units.data[index].id
                          //           ? TextStyle(
                          //               color: Colors.black,
                          //               fontSize: 22.0,
                          //               fontWeight: FontWeight.bold,
                          //             )
                          //           : TextStyle(
                          //               color: Colors.grey,
                          //               fontSize: 20.0,
                          //               fontWeight: FontWeight.normal,
                          //             ),
                          //     ),
                          //   ),
                          //   onTap: () {
                          //     enabledUnitId = state.units.data[index].id;
                          //     setState(
                          //       () {},
                          //     );
                          //     switch (_tabController.index) {
                          //       case 0:
                          //         context.bloc<QuestionBankBloc>().add(
                          //               GetUnitQuestions(
                          //                 widget.subjectId,
                          //                 state.units.data[0].id,
                          //               ),
                          //             );
                          //         break;
                          //       case 1:
                          //         context.bloc<QuestionBankObjectiveBloc>().add(
                          //               GetUnitObjectiveQuestions(
                          //                 widget.subjectId,
                          //                 state.units.data[0].id,
                          //               ),
                          //             );
                          //         break;
                          //       case 2:
                          //         context.bloc<QuestionBankSubjectiveBloc>().add(
                          //               GetUnitSubjectiveQuestions(
                          //                 widget.subjectId,
                          //                 state.units.data[0].id,
                          //               ),
                          //             );
                          //         break;
                          //     }
                          //   },
                          // ),
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
                  indicatorColor: Theme.of(context).primaryColor,
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
                    // Tab(
                    //   child: Text(
                    //     'All',
                    //   ),
                    // ),
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
                      // BlocProvider.value(
                      //   value: context.bloc<QuestionBankBloc>(),
                      //   child: QuestionBankAllTab(
                      //     widget.subjectId,
                      //     _tabController,
                      //   ),
                      // // ),
                      // BlocProvider(
                      //   create: (_) => context.bloc<QuestionBankBloc>(),
                      //   child: QuestionBankObjectiveTab(
                      //     widget.subjectId,
                      //   ),
                      // ),
                      BlocProvider(
                        create: (_) => context.bloc<QuestionBankBloc>(),
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

  @override
  bool get wantKeepAlive => false;
}
