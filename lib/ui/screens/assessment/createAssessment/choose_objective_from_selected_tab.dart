import 'package:edwisely/data/cubits/get_units_cubit.dart';
import 'package:edwisely/data/cubits/opic_questions_cubit.dart';
import 'package:edwisely/data/cubits/unit_topic_cubit.dart';
import 'package:edwisely/data/model/assessment/topicQuestionsEntity/data.dart';
import 'package:edwisely/data/model/assessment/unitTopic/topic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';

import '../../../../data/cubits/objective_questions_cubit.dart';
import '../../../../data/cubits/question_add_cubit.dart';
import '../../../../data/cubits/topic_cubit.dart';
import '../../../../data/cubits/unit_cubit.dart';
import '../../../../data/provider/selected_page.dart';
import '../../../../util/enums/question_type_enum.dart';
import '../../../widgets_util/big_app_bar_add_questions.dart';
import '../../../widgets_util/navigation_drawer.dart';

class ChooseObjectiveFromSelectedTab extends StatefulWidget {
  final String _title;
  final String _description;
  final int _subjectId;
  final QuestionType _questionType;
  final int _assessmentId;

  ChooseObjectiveFromSelectedTab(
      this._title, this._description, this._subjectId, this._questionType, this._assessmentId);

  @override
  _ChooseObjectiveFromSelectedTabState createState() => _ChooseObjectiveFromSelectedTabState();
}

class _ChooseObjectiveFromSelectedTabState extends State<ChooseObjectiveFromSelectedTab>
    with SingleTickerProviderStateMixin {
  final _questionFetchCubit = QuestionsCubit();

  final topicCubit = TopicCubit();

  final unitCubit = UnitCubit();
  TabController tabController;
  int bloomsFilter = 0;
  List<Data> data;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('subject id in choose_objectivefromselected ${widget._subjectId}');
    List<int> topics = [];
    List<int> subTopics = [];
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
                  route: 'Home > Add Question > Add Objective Question',
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
                              state.assessmentQuestionsEntity.data.forEach((element) {
                                questions.add(element.id);
                              });
                              return ListView.builder(
                                itemCount: state.assessmentQuestionsEntity.data.length,
                                itemBuilder: (BuildContext context, int index) => Card(
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        Text('Q ${index + 1}   '),
                                        Expanded(
                                          child: Text(
                                            state.assessmentQuestionsEntity.data[index].name,
                                            // overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
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
                                child: BlocBuilder(
                              builder: (BuildContext context, state) {
                                if (state is TopicQuestionsFetched) {
                                  if (data == null) {
                                    data = List.unmodifiable(state.data);
                                  }
                                  return StatefulBuilder(
                                    builder: (BuildContext context,
                                        void Function(void Function()) setState) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: state.data.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return CheckboxListTile(
                                            subtitle: Text(state.data[index].solution),
                                            title: Row(
                                              children: [
                                                Text('Q ${index + 1}'),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    state.data[index].name,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(),
                                                  ),
                                                )
                                              ],
                                            ),
                                            value: questions.contains(state.data[index].id),
                                            onChanged: (flag) {
                                              setState(
                                                () {
                                                  flag
                                                      ? questions.add(state.data[index].id)
                                                      : questions.remove(state.data[index].id);
                                                },
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                  );
                                }
                                if (state is TopicQuestionsFailed) {
                                  return Center(
                                    child: Text(state.error),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                              cubit: context.bloc<TopicQuestionsCubit>(),
                            )),
                            Container(
                              width: MediaQuery.of(context).size.width / 6,
                              child: Column(
                                children: [
                                  StatefulBuilder(
                                    builder: (BuildContext context,
                                        void Function(void Function()) setState) {
                                      return DropdownButton<int>(
                                        items: [
                                          DropdownMenuItem(
                                            child: Text('All'),
                                            value: 0,
                                          ),
                                          DropdownMenuItem(
                                            child: Text('Remember'),
                                            value: 1,
                                          ),
                                          DropdownMenuItem(
                                            child: Text('Understand'),
                                            value: 2,
                                          ),
                                          DropdownMenuItem(
                                            child: Text('Apply'),
                                            value: 3,
                                          ),
                                          DropdownMenuItem(
                                            child: Text('Analyze'),
                                            value: 4,
                                          ),
                                        ],
                                        onChanged: (int value) => setState(() {
                                          bloomsFilter = value;
                                          context
                                              .bloc<TopicQuestionsCubit>()
                                              .getBloomsQuestions(value, data);
                                        }),
                                        value: bloomsFilter,
                                      );
                                    },
                                  ),
                                  BlocBuilder(
                                    cubit: context.bloc<GetUnitsCubit>()
                                      ..getUnits(widget._subjectId),
                                    builder: (BuildContext context, state) {
                                      if (state is GetUnitsFetched) {
                                        int enabledUnitId = state.getUnitsEntity.data[0].id;
                                        unitId = state.getUnitsEntity.data[0].id;
                                        context.bloc<UnitTopicCubit>().getTopics(
                                              unitId,
                                            );
                                        return StatefulBuilder(
                                          builder: (BuildContext context,
                                              void Function(void Function()) setState) {
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: state.getUnitsEntity.data.length,
                                              itemBuilder: (BuildContext context, int index) =>
                                                  ListTile(
                                                hoverColor: Colors.white,
                                                selected: enabledUnitId ==
                                                    state.getUnitsEntity.data[index].id,
                                                title: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      state.getUnitsEntity.data[index].name,
                                                      style: TextStyle(
                                                          color: enabledUnitId ==
                                                                  state
                                                                      .getUnitsEntity.data[index].id
                                                              ? Colors.black
                                                              : Colors.grey.shade600,
                                                          fontSize: enabledUnitId ==
                                                                  state
                                                                      .getUnitsEntity.data[index].id
                                                              ? 25
                                                              : null),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  setState(
                                                    () {
                                                      enabledUnitId =
                                                          state.getUnitsEntity.data[index].id;
                                                      unitId = state.getUnitsEntity.data[index].id;
                                                    },
                                                  );
                                                  context.bloc<UnitTopicCubit>().getTopics(
                                                        unitId,
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
                                  BlocBuilder(
                                    cubit: context.bloc<UnitTopicCubit>(),
                                    builder: (BuildContext context, state) {
                                      if (state is UnitTopicFetched) {
                                        state.topics.forEach((element) {
                                          topics.add(element.topic_id);
                                        });
                                        state.subTopics.forEach((element) {
                                          subTopics.add(element.topic_id);
                                        });
                                        context
                                            .bloc<TopicQuestionsCubit>()
                                            .getTopicQuestions(topics, subTopics);
                                        return StatefulBuilder(
                                          builder: (BuildContext context, StateSetter setState) {
                                            return Column(
                                              children: [
                                                SmartSelect.multiple(
                                                  title: 'Topics',
                                                  value: topics,
                                                  onChange: (state) {
                                                    setState(() => topics = state.value);
                                                    context
                                                        .bloc<TopicQuestionsCubit>()
                                                        .getTopicQuestions(topics, subTopics);
                                                  },
                                                  modalType: S2ModalType.popupDialog,
                                                  choiceItems: S2Choice.listFrom(
                                                    source: state.topics,
                                                    value: (index, Topic item) => item.topic_id,
                                                    title: (index, Topic item) => item.topic_name,
                                                    group: (index, Topic item) => item.topic_code,
                                                  ),
                                                  choiceType: S2ChoiceType.chips,
                                                  modalConfirm: true,
                                                ),
                                                SmartSelect.multiple(
                                                  title: 'Sub Topics',
                                                  value: subTopics,
                                                  onChange: (state) {
                                                    setState(() => subTopics = state.value);
                                                    context
                                                        .bloc<TopicQuestionsCubit>()
                                                        .getTopicQuestions(topics, subTopics);
                                                  },
                                                  modalType: S2ModalType.popupDialog,
                                                  choiceItems: S2Choice.listFrom(
                                                    source: state.subTopics,
                                                    value: (index, Topic item) => item.topic_id,
                                                    title: (index, Topic item) => item.topic_name,
                                                    group: (index, Topic item) => item.topic_code,
                                                  ),
                                                  choiceType: S2ChoiceType.chips,
                                                  modalConfirm: true,
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                      if (state is UnitTopicEmpty) {
                                        context.bloc<TopicQuestionsCubit>().emit(
                                            TopicQuestionsFailed('No Questions for this Unit'));
                                        return Text('No topics to Tag');
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
                                  RaisedButton.icon(
                                    onPressed: () {
                                      questions.isEmpty
                                          ? null
                                          : context
                                              .bloc<QuestionAddCubit>()
                                              .addQuestions(widget._assessmentId, questions, []);
                                      Future.delayed(
                                          Duration(seconds: 2),
                                          () => _questionFetchCubit
                                              .getQuestionsToAnAssessment(widget._assessmentId));
                                    },
                                    icon: Icon(Icons.add),
                                    label: Text('Add'),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
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
