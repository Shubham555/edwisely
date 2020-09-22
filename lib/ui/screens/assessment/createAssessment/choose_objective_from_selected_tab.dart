import 'dart:convert';

import 'package:catex/catex.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/blocs/questionBank/questionBankObjective/question_bank_objective_bloc.dart';
import 'package:edwisely/data/cubits/objective_questions_cubit.dart';
import 'package:edwisely/data/cubits/topic_cubit.dart';
import 'package:edwisely/data/cubits/unit_cubit.dart';
import 'package:edwisely/data/model/questionBank/topicEntity/data.dart';
import 'package:edwisely/ui/widgets_util/big_app_bar_add_questions.dart';
import 'package:edwisely/ui/widgets_util/navigation_drawer.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../data/provider/selected_page.dart';

class ChooseObjectiveFromSelectedTab extends StatefulWidget {
  final String _title;
  final String _description;
  final int _subjectId;
  final QuestionType _questionType;
  final int _assessmentId;

  ChooseObjectiveFromSelectedTab(this._title, this._description,
      this._subjectId, this._questionType, this._assessmentId);

  @override
  _ChooseObjectiveFromSelectedTabState createState() =>
      _ChooseObjectiveFromSelectedTabState();
}

class _ChooseObjectiveFromSelectedTabState
    extends State<ChooseObjectiveFromSelectedTab> {
  final _questionFetchCubit = QuestionsCubit();

  final topicCubit = TopicCubit();

  final objectiveBloc = QuestionBankObjectiveBloc();

  final unitCubit = UnitCubit();

  @override
  Widget build(BuildContext context) {
    int topicId;
    int unitId;
    List<int> questions = [];
    return Scaffold(
      body: Row(
        children: [
          NavigationDrawer(
            isCollapsed: true,
            key: context.watch<SelectedPageProvider>().navigatorKey,
          ),
          Expanded(
            child: Column(
              children: [
                BigAppBarAddQuestionScreen(
                  actions: [],
                  appBarSize: MediaQuery.of(context).size.height * 0.3,
                  appBarTitle: Text(
                    'Edwisely',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  flatButton: FlatButton(
                    onPressed: () => null,
                    child: Text('Save'),
                  ),
                  titleText: 'Add Questions to ${widget._title} Assessment',
                  description: "${widget._description}",
                  subject: "Subject: ${widget._subjectId}",
                ).build(context),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 6,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.grey.shade500,
                        child: BlocBuilder(
                          cubit: _questionFetchCubit
                            ..getQuestionsToAnAssessment(
                              widget._assessmentId,
                            ),
                          builder: (BuildContext context, state) {
                            if (state is QuestionsToAnAssessmentFetched) {
                              return ListView.builder(
                                itemCount:
                                    state.assessmentQuestionsEntity.data.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        ListTile(
                                  title: CaTeX(
                                    state.assessmentQuestionsEntity.data[index]
                                        .name,
                                  ),
                                ),
                              );
                            }
                            if (state is QuestionsToAnAssessmentEmpty) {
                              return Center(
                                child: Text('Add Questions to this Assessment'),
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
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      RaisedButton(
                                          child: Text('Remember'),
                                          onPressed: () => objectiveBloc.add(
                                              GetUnitObjectiveQuestionsByLevel(
                                                  1, unitId))),
                                      RaisedButton(
                                          child: Text('Understand'),
                                          onPressed: () => objectiveBloc.add(
                                              GetUnitObjectiveQuestionsByLevel(
                                                  2, unitId))),
                                      RaisedButton(
                                          child: Text('Apply'),
                                          onPressed: () => objectiveBloc.add(
                                              GetUnitObjectiveQuestionsByLevel(
                                                  3, unitId))),
                                      RaisedButton(
                                          child: Text('Analyze'),
                                          onPressed: () => objectiveBloc.add(
                                              GetUnitObjectiveQuestionsByLevel(
                                                  4, unitId))),
                                    ],
                                  ),
                                  StatefulBuilder(
                                    builder: (BuildContext context,
                                        void Function(void Function())
                                            setState) {
                                      return BlocBuilder(
                                        cubit: objectiveBloc,
                                        builder: (BuildContext context, state) {
                                          if (state
                                              is UnitObjectiveQuestionsFetched) {
                                            return Expanded(
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: state
                                                    .questionBankObjectiveEntity
                                                    .data
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return CheckboxListTile(
                                                    subtitle: Text(state
                                                        .questionBankObjectiveEntity
                                                        .data[index]
                                                        .solution),
                                                    title: Row(
                                                      children: [
                                                        Text('Q ${index + 1}'),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            state
                                                                .questionBankObjectiveEntity
                                                                .data[index]
                                                                .name,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    value: questions.contains(state
                                                        .questionBankObjectiveEntity
                                                        .data[index]
                                                        .id),
                                                    onChanged: (flag) {
                                                      setState(() {
                                                        flag
                                                            ? questions.add(state
                                                                .questionBankObjectiveEntity
                                                                .data[index]
                                                                .id)
                                                            : questions.remove(state
                                                                .questionBankObjectiveEntity
                                                                .data[index]
                                                                .id);
                                                      });
                                                    },
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                          if (state
                                              is QuestionBankObjectiveEmpty) {
                                            return Text('No Questions');
                                          } else {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 6,
                              child: Column(
                                children: [
                                  BlocBuilder(
                                    cubit: unitCubit
                                      ..getUnitsOfACourse(widget._subjectId),
                                    builder: (BuildContext context, state) {
                                      if (state is CourseUnitFetched) {
                                        int enabledUnitId =
                                            state.units.data[0].id;
                                        unitId = state.units.data[0].id;
                                        objectiveBloc.add(
                                            GetUnitObjectiveQuestions(
                                                widget._subjectId,
                                                state.units.data[0].id));
                                        return StatefulBuilder(
                                          builder: (BuildContext context,
                                              void Function(void Function())
                                                  setState) {
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  state.units.data.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                          int index) =>
                                                      ListTile(
                                                hoverColor: Colors.white,
                                                selected: enabledUnitId ==
                                                    state.units.data[index].id,
                                                title: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      state.units.data[index]
                                                          .name,
                                                      style: TextStyle(
                                                          color: enabledUnitId ==
                                                                  state
                                                                      .units
                                                                      .data[
                                                                          index]
                                                                      .id
                                                              ? Colors.black
                                                              : Colors.grey
                                                                  .shade600,
                                                          fontSize: enabledUnitId ==
                                                                  state
                                                                      .units
                                                                      .data[
                                                                          index]
                                                                      .id
                                                              ? 25
                                                              : null),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  setState(
                                                    () {
                                                      enabledUnitId = state
                                                          .units.data[index].id;
                                                      unitId = state
                                                          .units.data[index].id;
                                                    },
                                                  );

                                                  objectiveBloc.add(
                                                    GetUnitObjectiveQuestions(
                                                        widget._subjectId,
                                                        unitId),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      }
                                      if (state is CourseUnitEmpty) {
                                        return Text('No Units to fetch');
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
                                  //todo fix
                                  BlocBuilder(
                                    cubit: topicCubit..getTopics(45, 71),
                                    builder: (BuildContext context, state) {
                                      if (state is TopicFetched) {
                                        return StatefulBuilder(
                                          builder: (BuildContext context,
                                              void Function(void Function())
                                                  setState) {
                                            return ChipsChoice<int>.single(
                                              isWrapped: true,
                                              value: topicId,
                                              options:
                                                  ChipsChoiceOption.listFrom(
                                                source: state.topicEntity.data,
                                                value: (i, Data v) => v.id,
                                                label: (i, Data v) => v.name,
                                              ),
                                              onChanged: (int value) {
                                                setState(() {
                                                  topicId = value;
                                                });
                                                objectiveBloc.add(
                                                  GetUnitObjectiveQuestionsByTopic(
                                                      value, unitId),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      }
                                      if (state is TopicEmpty) {
                                        return Text('No topics to Tag');
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),

                                  onChanged: (int value) {
                                    setState(() {
                                      topicId = value;
                                    });
                                    objectiveBloc.add(
                                      GetUnitObjectiveQuestionsByTopic(
                                          value, unitId),
                                    );
                                  },
                                );
                              },
                            );
                          }
                          if (state is TopicEmpty) {
                            return Text('No topics to Tag');
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      RaisedButton.icon(
                        onPressed: () async => questions.isEmpty
                            ? null
                            : await EdwiselyApi.dio
                                .post(
                                'questionnaireWeb/editObjectiveTestQuestions',
                                data: FormData.fromMap(
                                  {
                                    'test_id': widget._assessmentId,
                                    'questions': jsonEncode(questions),
                                    'units': jsonEncode([])
                                  },
                                ),
                              )
                                .then((value) {
                                context
                                    .bloc<QuestionsCubit>()
                                    .getQuestionsToAnAssessment(
                                      widget._assessmentId,
                                    );

                                Navigator.pop(context);
                              }),
                        icon: Icon(Icons.add),
                        label: Text('Add'),
                      )
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
