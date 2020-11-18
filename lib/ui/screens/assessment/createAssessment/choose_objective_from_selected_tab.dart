import 'package:edwisely/data/cubits/get_units_cubit.dart';
import 'package:edwisely/data/cubits/opic_questions_cubit.dart';
import 'package:edwisely/data/cubits/unit_topic_cubit.dart';
import 'package:edwisely/data/model/assessment/topicQuestionsEntity/data.dart';
import 'package:edwisely/data/model/assessment/unitTopic/topic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';
import 'package:websafe_svg/websafe_svg.dart';

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

  ChooseObjectiveFromSelectedTab(this._title, this._description,
      this._subjectId, this._questionType, this._assessmentId);

  @override
  _ChooseObjectiveFromSelectedTabState createState() =>
      _ChooseObjectiveFromSelectedTabState();
}

class _ChooseObjectiveFromSelectedTabState
    extends State<ChooseObjectiveFromSelectedTab>
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
                  flatButton: RaisedButton(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/save.png',
                          color: Colors.white,
                          height: 24.0,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Save',
                          style: Theme.of(context).textTheme.button,
                        ),
                      ],
                    ),
                  ),
                  titleText: '${widget._title}',
                  description: "${widget._description}",
                  subject: "Subject: ${widget._subjectId}",
                ).build(context),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 6,
                        height: MediaQuery.of(context).size.height,
                        margin: const EdgeInsets.symmetric(
                          vertical: 22.0,
                          horizontal: 22.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                          ),
                        ),
                        child: BlocBuilder(
                          cubit: _questionFetchCubit
                            ..getQuestionsToAnAssessment(
                              widget._assessmentId,
                            ),
                          builder: (BuildContext context, state) {
                            if (state is QuestionsToAnAssessmentFetched) {
                              state.assessmentQuestionsEntity.data
                                  .forEach((element) {
                                questions.add(element.id);
                              });
                              return ListView.builder(
                                itemCount:
                                    state.assessmentQuestionsEntity.data.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black,
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                  child: ListTile(
                                    onTap: () => showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        backgroundColor: Colors.transparent,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.72,
                                          color: Colors.white,
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: SizedBox(
                                                  height: 250,
                                                  child: TeXView(
                                                    child: TeXViewDocument(
                                                      state
                                                          .assessmentQuestionsEntity
                                                          .data[index]
                                                          .name
                                                          .replaceAll(
                                                              '\$', '\$\$'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  width: 250,
                                                  height: 250,
                                                  child: Image.network(state
                                                      .assessmentQuestionsEntity
                                                      .data[index]
                                                      .question_img)),
                                              ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: state
                                                    .assessmentQuestionsEntity
                                                    .data[index]
                                                    .questions_options
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int indexi) {
                                                  return Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    color: state
                                                                .assessmentQuestionsEntity
                                                                .data[index]
                                                                .questions_options[
                                                                    indexi]
                                                                .is_answer ==
                                                            0
                                                        ? null
                                                        : Colors.greenAccent
                                                            .withOpacity(.5),
                                                    child: ListTile(
                                                        title: Text(state
                                                            .assessmentQuestionsEntity
                                                            .data[index]
                                                            .questions_options[
                                                                indexi]
                                                            .name)),
                                                  );
                                                },
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: RaisedButton.icon(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                  ),
                                                  label: Text('Close',
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    title: Row(
                                      children: [
                                        Text(
                                          'Q ${index + 1}   ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        Expanded(
                                          child: Text(
                                            state.assessmentQuestionsEntity
                                                .data[index].name,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .copyWith(fontSize: 14.0),
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
                                cubit: context.bloc<GetUnitsCubit>(),
                                builder: (BuildContext context, state) {
                                  if (state is GetUnitsFetched) {
                                    return BlocBuilder(
                                      builder: (BuildContext context, state) {
                                        if (state is TopicQuestionsFetched) {
                                          if (data == null) {
                                            data =
                                                List.unmodifiable(state.data);
                                          }
                                          return Container(
                                            margin: const EdgeInsets.symmetric(
                                              vertical: 22.0,
                                              horizontal: 18.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 0.5,
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                StatefulBuilder(builder:
                                                    (context, setState) {
                                                  return _buildBloomLevelSelector(
                                                      state.data, setState);
                                                }),
                                                Expanded(
                                                  child: StatefulBuilder(
                                                    builder: (BuildContext
                                                            context,
                                                        void Function(
                                                                void Function())
                                                            setState) {
                                                      return ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            state.data.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          var answer;
                                                          state.data[index]
                                                              .questions_options
                                                              .forEach(
                                                                  (options) {
                                                            if (options
                                                                    .is_answer ==
                                                                1)
                                                              answer =
                                                                  options.name;
                                                          });
                                                          return Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              vertical: 8.0,
                                                              horizontal: 18.0,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: index %
                                                                          2 ==
                                                                      0
                                                                  ? Colors.white
                                                                  : Theme.of(
                                                                          context)
                                                                      .primaryColor
                                                                      .withOpacity(
                                                                          0.1),
                                                              border: Border(
                                                                bottom:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 0.2,
                                                                ),
                                                              ),
                                                            ),
                                                            child:
                                                                CheckboxListTile(
                                                              activeColor: Theme
                                                                      .of(context)
                                                                  .primaryColor,
                                                              subtitle: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  //correct Answer
                                                                  Text(
                                                                    'Answer : $answer',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                  FlatButton(
                                                                    onPressed: () => _showDetailDialog(
                                                                        state.data[
                                                                            index],
                                                                        context),
                                                                    child: Text(
                                                                        'View More'),
                                                                  ),
                                                                ],
                                                              ),
                                                              title: Row(
                                                                children: [
                                                                  Text(
                                                                    'Q ${index + 1}',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headline5,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 22.0,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      state
                                                                          .data[
                                                                              index]
                                                                          .name,
                                                                      softWrap:
                                                                          true,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          2,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .headline6,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              value: questions
                                                                  .contains(state
                                                                      .data[
                                                                          index]
                                                                      .id),
                                                              onChanged:
                                                                  (flag) {
                                                                setState(
                                                                  () {
                                                                    flag
                                                                        ? questions.add(state
                                                                            .data[
                                                                                index]
                                                                            .id)
                                                                        : questions.remove(state
                                                                            .data[index]
                                                                            .id);
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                        if (state is TopicQuestionsFailed) {
                                          return Center(
                                            child: Column(
                                              children: [
                                                Text(state.error),
                                                state.error ==
                                                        'No Questions for this Unit'
                                                    ? Container()
                                                    : RaisedButton(
                                                        onPressed: () {
                                                          context.bloc<
                                                              GetUnitsCubit>()
                                                            ..getUnits(widget
                                                                ._subjectId);
                                                          bloomsFilter = 0;
                                                        },
                                                        child: Text('Reload'),
                                                      )
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                      cubit:
                                          context.bloc<TopicQuestionsCubit>(),
                                    );
                                  }
                                  if (state is GetUnitsFetchFailed) {
                                    return Center(child: Text('No Questions'));
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 6,
                              margin: const EdgeInsets.only(
                                  left: 18.0, right: 12.0, top: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // StatefulBuilder(
                                  //   builder: (BuildContext context, void Function(void Function()) setState) {
                                  //     return DropdownButton<int>(
                                  //       items: [
                                  //         DropdownMenuItem(
                                  //           child: Text('All'),
                                  //           value: 0,
                                  //         ),
                                  //         DropdownMenuItem(
                                  //           child: Text('Remember'),
                                  //           value: 1,
                                  //         ),
                                  //         DropdownMenuItem(
                                  //           child: Text('Understand'),
                                  //           value: 2,
                                  //         ),
                                  //         DropdownMenuItem(
                                  //           child: Text('Apply'),
                                  //           value: 3,
                                  //         ),
                                  //         DropdownMenuItem(
                                  //           child: Text('Analyze'),
                                  //           value: 4,
                                  //         ),
                                  //       ],
                                  //       onChanged: (int value) => setState(() {
                                  //         bloomsFilter = value;
                                  //         context.bloc<TopicQuestionsCubit>().getBloomsQuestions(value, data);
                                  //       }),
                                  //       value: bloomsFilter,
                                  //     );
                                  //   },
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 22.0, top: 12.0),
                                    child: RaisedButton.icon(
                                      onPressed: () {
                                        questions.isEmpty
                                            ? null
                                            : context
                                                .bloc<QuestionAddCubit>()
                                                .addQuestions(
                                                    widget._assessmentId,
                                                    questions, []);
                                        Future.delayed(
                                            Duration(seconds: 2),
                                            () => _questionFetchCubit
                                                .getQuestionsToAnAssessment(
                                                    widget._assessmentId));
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        'Add',
                                        style:
                                            Theme.of(context).textTheme.button,
                                      ),
                                    ),
                                  ),
                                  BlocBuilder(
                                    cubit: context.bloc<GetUnitsCubit>()
                                      ..getUnits(widget._subjectId),
                                    builder: (BuildContext context, state) {
                                      if (state is GetUnitsFetched) {
                                        int enabledUnitId =
                                            state.getUnitsEntity.data[0].id;
                                        unitId =
                                            state.getUnitsEntity.data[0].id;
                                        context
                                            .bloc<UnitTopicCubit>()
                                            .getTopics(
                                              unitId,
                                            );
                                        return Container(
                                          margin: const EdgeInsets.only(
                                              right: 22.0, top: 12.0),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                            horizontal: 12.0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 0.5,
                                            ),
                                          ),
                                          child: StatefulBuilder(
                                            builder: (BuildContext context,
                                                void Function(void Function())
                                                    setState) {
                                              return ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: state
                                                    .getUnitsEntity.data.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                            int index) =>
                                                        Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 16.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(
                                                        () {
                                                          enabledUnitId = state
                                                              .getUnitsEntity
                                                              .data[index]
                                                              .id;
                                                          unitId = state
                                                              .getUnitsEntity
                                                              .data[index]
                                                              .id;
                                                        },
                                                      );
                                                      context
                                                          .bloc<
                                                              UnitTopicCubit>()
                                                          .getTopics(
                                                            unitId,
                                                          );
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        AnimatedDefaultTextStyle(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  300),
                                                          style: enabledUnitId ==
                                                                  state
                                                                      .getUnitsEntity
                                                                      .data[
                                                                          index]
                                                                      .id
                                                              ? TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      22.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )
                                                              : TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize:
                                                                      20.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          child: Text(
                                                            state
                                                                .getUnitsEntity
                                                                .data[index]
                                                                .name,
                                                          ),
                                                        ),
                                                        SizedBox(height: 2.0),
                                                        AnimatedContainer(
                                                          duration: Duration(
                                                            milliseconds: 300,
                                                          ),
                                                          width: enabledUnitId ==
                                                                  state
                                                                      .getUnitsEntity
                                                                      .data[
                                                                          index]
                                                                      .id
                                                              ? 80.0
                                                              : 40.0,
                                                          height: 3.0,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                        // ListTile(
                                                        //   hoverColor: Colors.white,
                                                        //   selected: enabledUnitId == state.getUnitsEntity.data[index].id,
                                                        //   title: Row(
                                                        //     mainAxisAlignment: MainAxisAlignment.center,
                                                        //     children: [
                                                        //       Text(
                                                        //         state.getUnitsEntity.data[index].name,
                                                        //         style: TextStyle(
                                                        //             color: enabledUnitId == state.getUnitsEntity.data[index].id
                                                        //                 ? Colors.black
                                                        //                 : Colors.grey.shade600,
                                                        //             fontSize: enabledUnitId == state.getUnitsEntity.data[index].id ? 25 : null),
                                                        //       ),
                                                        //     ],
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      }
                                      if (state is GetUnitsFetchFailed) {
                                        return Text('No Units to fetch');
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
                                  BlocBuilder(
                                    cubit: context.bloc<GetUnitsCubit>(),
                                    builder: (BuildContext context, state) {
                                      if (state is GetUnitsFetched) {
                                        return BlocBuilder(
                                          cubit: context.bloc<UnitTopicCubit>(),
                                          builder:
                                              (BuildContext context, state) {
                                            if (state is UnitTopicFetched) {
                                              state.topics.forEach((element) {
                                                topics.add(element.topic_id);
                                              });
                                              state.subTopics
                                                  .forEach((element) {
                                                subTopics.add(element.topic_id);
                                              });
                                              context
                                                  .bloc<TopicQuestionsCubit>()
                                                  .getTopicQuestions(
                                                      topics, subTopics);
                                              return StatefulBuilder(
                                                builder: (BuildContext context,
                                                    StateSetter setState) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(height: 12.0),
                                                      Text(
                                                        'Selected Topics',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .copyWith(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                      ),
                                                      SizedBox(
                                                        child: SmartSelect
                                                            .multiple(
                                                          title: 'Topic:',
                                                          value: topics +
                                                              subTopics,
                                                          onChange: (state) {
                                                            setState(() {
                                                              topics =
                                                                  state.value;
                                                              subTopics =
                                                                  state.value;
                                                            });
                                                            context
                                                                .bloc<
                                                                    TopicQuestionsCubit>()
                                                                .getTopicQuestions(
                                                                    topics,
                                                                    subTopics);
                                                          },
                                                          modalType: S2ModalType
                                                              .popupDialog,
                                                          choiceItems:
                                                              S2Choice.listFrom(
                                                            source: state
                                                                    .topics +
                                                                state.subTopics,
                                                            value: (index,
                                                                    Topic
                                                                        item) =>
                                                                item.topic_id,
                                                            title: (index,
                                                                    Topic
                                                                        item) =>
                                                                item.topic_name,
                                                            group: (index,
                                                                    Topic
                                                                        item) =>
                                                                item.topic_code,
                                                          ),
                                                          choiceType:
                                                              S2ChoiceType
                                                                  .chips,
                                                          modalConfirm: true,
                                                        ),
                                                      ),
                                                      // SmartSelect.multiple(
                                                      //   title: 'Sub Topics',
                                                      //   value: subTopics,
                                                      //   onChange: (state) {
                                                      //     setState(() => subTopics = state.value);
                                                      //     context.bloc<TopicQuestionsCubit>().getTopicQuestions(topics, subTopics);
                                                      //   },
                                                      //   modalType: S2ModalType.popupDialog,
                                                      //   choiceItems: S2Choice.listFrom(
                                                      //     source: state.subTopics,
                                                      //     value: (index, Topic item) => item.topic_id,
                                                      //     title: (index, Topic item) => item.topic_name,
                                                      //     group: (index, Topic item) => item.topic_code,
                                                      //   ),
                                                      //   choiceType: S2ChoiceType.chips,
                                                      //   modalConfirm: true,
                                                      // ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                            if (state is UnitTopicEmpty) {
                                              context
                                                  .bloc<TopicQuestionsCubit>()
                                                  .emit(TopicQuestionsFailed(
                                                      'No Questions for this Unit'));
                                              return Text('No topics to Tag');
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        );
                                      }
                                      if (state is GetUnitsFetchFailed) {
                                        return Text('No Topics to tag');
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
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

  Widget _buildBloomLevelSelector(List<Data> actualData, Function setState) {
    return Transform.translate(
      offset: Offset(0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _bloomLevel(0, bloomsFilter, onBloomChanged, 'All',
              'assets/icons/blooms/all.svg', actualData, setState),
          _bloomLevel(1, bloomsFilter, onBloomChanged, 'Remember',
              'assets/icons/blooms/all.svg', actualData, setState),
          _bloomLevel(2, bloomsFilter, onBloomChanged, 'Understand',
              'assets/icons/blooms/understand.svg', actualData, setState),
          _bloomLevel(3, bloomsFilter, onBloomChanged, 'Apply',
              'assets/icons/blooms/apply.svg', actualData, setState),
          _bloomLevel(4, bloomsFilter, onBloomChanged, 'Analyze',
              'assets/icons/blooms/analyze.svg', actualData, setState),
        ],
      ),
    );
  }

  Widget _bloomLevel(int myValue, int selectedValue, Function onTap,
      String title, String image, List<Data> actualData, Function setState) {
    bool isSelected = myValue == selectedValue;

    return Flexible(
      flex: 1,
      child: InkWell(
        onTap: () {
          setState(() {
            bloomsFilter = myValue;
            context
                .bloc<TopicQuestionsCubit>()
                .getBloomsQuestions(myValue, actualData);
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(myValue == 0 ? 12.0 : 0.0),
              topRight: Radius.circular(myValue == 4 ? 12.0 : 0.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Column(
            children: [
              WebsafeSvg.asset(
                image,
                color: isSelected ? Colors.white : Colors.black,
                height: 24.0,
              ),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: isSelected ? Colors.white : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onBloomChanged(int value, List<Data> actualData, Function setState) {
    setState(() {
      bloomsFilter = value;
      context.bloc<TopicQuestionsCubit>().getBloomsQuestions(value, actualData);
    });
    // bloomsFilter = value;
    // context.bloc<TopicQuestionsCubit>().getBloomsQuestions(value, actualData);
  }

  _showDetailDialog(Data data, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.72,
          color: Colors.white,
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  height: 250,
                  child: TeXView(
                    child: TeXViewDocument(
                      data.name.replaceAll('\$', '\$\$'),
                    ),
                  ),
                ),
              ),
              Container(
                  width: 250,
                  height: 250,
                  child: Image.network(data.question_img)),
              ListView.builder(
                shrinkWrap: true,
                itemCount: data.questions_options.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(12.0),
                    color: data.questions_options[index].is_answer == 0
                        ? null
                        : Colors.greenAccent.withOpacity(.5),
                    child: ListTile(
                        title: Text(data.questions_options[index].name)),
                  );
                },
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: RaisedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  label: Text('Close', style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
