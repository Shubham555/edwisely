import 'package:dio/dio.dart';
import 'package:edwisely/data/cubits/unit_cubit.dart';
import 'package:edwisely/data/model/questionBank/questionBankObjective/data.dart';
import 'package:edwisely/data/model/questionBank/topicEntity/TopicEntity.dart';
import 'package:edwisely/ui/screens/assessment/createAssessment/type_question_tab.dart';
import 'package:edwisely/util/enums/question_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

import '../../../../../data/api/api.dart';
import '../../../../../data/blocs/questionBank/questionBankObjective/question_bank_objective_bloc.dart';
import '../../../../../main.dart';

class QuestionBankObjectiveTab extends StatefulWidget {
  final int subjectId;
  final int subjectsubjectId;

  QuestionBankObjectiveTab(this.subjectId, this.subjectsubjectId);

  @override
  _QuestionBankObjectiveTabState createState() =>
      _QuestionBankObjectiveTabState();
}

class _QuestionBankObjectiveTabState extends State<QuestionBankObjectiveTab> {
  int levelDropDownValue = -1;
  int topicsDropDown = 1234567890;
  int isSelected = 0;
  int questionsDropDownValue = 1;
  var currentUnit = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 16.0,
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bloom Level'),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: DropdownButton(
                        underline: SizedBox.shrink(),
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'All',
                              overflow: TextOverflow.ellipsis,
                            ),
                            value: -1,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Remember',
                              overflow: TextOverflow.ellipsis,
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Understand',
                              overflow: TextOverflow.ellipsis,
                            ),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Apply',
                              overflow: TextOverflow.ellipsis,
                            ),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Analyze',
                              overflow: TextOverflow.ellipsis,
                            ),
                            value: 4,
                          ),
                        ],
                        value: levelDropDownValue,
                        onChanged: (value) {
                          setState(
                            () {
                              levelDropDownValue = value;
                            },
                          );
                          value == -1
                              ? context.bloc<QuestionBankObjectiveBloc>().add(
                                    GetUnitObjectiveQuestions(
                                      widget.subjectId,
                                      currentUnit.value,
                                    ),
                                  )
                              : context.bloc<QuestionBankObjectiveBloc>().add(
                                    GetUnitObjectiveQuestionsByLevel(
                                        value,
                                        currentUnit.value,
                                        widget.subjectsubjectId),
                                  );
                        }),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              SizedBox(width: 18.0),
              FutureBuilder(
                future: EdwiselyApi.dio.get(
                    'questionnaireWeb/getSubjectTopics?subject_id=${widget.subjectsubjectId}&university_degree_department_id=$universityDegreeDepartmenId',
                    options: Options(headers: {
                      'Authorization': 'Bearer $loginToken',
                    })),
                builder: (BuildContext context,
                    AsyncSnapshot<Response<dynamic>> snapshot) {
                  if (snapshot.hasData) {
                    List<DropdownMenuItem> dropDownItems = [];
                    dropDownItems.add(
                      DropdownMenuItem(
                        child: Text('All'),
                        value: 1234567890,
                      ),
                    );

                    TopicEntity topicEntity =
                        TopicEntity.fromJsonMap(snapshot.data.data);
                    dropDownItems.addAll(
                      topicEntity.data.map(
                        (e) => DropdownMenuItem(
                          child: Text(e.name),
                          value: e.id,
                        ),
                      ),
                    );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Topic'),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: DropdownButton(
                            underline: SizedBox.shrink(),
                            isExpanded: true,
                            items: dropDownItems,
                            value: topicsDropDown,
                            onChanged: (value) {
                              setState(
                                () {
                                  topicsDropDown = value;
                                },
                              );
                              value == 1234567890
                                  ? context
                                      .bloc<QuestionBankObjectiveBloc>()
                                      .add(
                                        GetUnitObjectiveQuestions(
                                          widget.subjectId,
                                          currentUnit.value,
                                        ),
                                      )
                                  : context
                                      .bloc<QuestionBankObjectiveBloc>()
                                      .add(
                                        GetUnitObjectiveQuestionsByTopic(
                                            value,
                                            currentUnit.value,
                                            widget.subjectsubjectId),
                                      );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              SizedBox(width: 18.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Questions'),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: DropdownButton(
                      underline: SizedBox.shrink(),
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          child: Text('All Questions'),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text('Bookmarked'),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text('Your Questions'),
                          value: 3,
                        ),
                      ],
                      value: questionsDropDownValue,
                      onChanged: (value) {
                        setState(
                          () {
                            questionsDropDownValue = value;
                          },
                        );
                        switch (value) {
                          case 1:
                            {
                              context.bloc<QuestionBankObjectiveBloc>().add(
                                    GetUnitObjectiveQuestions(
                                      widget.subjectId,
                                      currentUnit.value,
                                    ),
                                  );
                            }
                            break;
                          case 2:
                            {
                              context.bloc<QuestionBankObjectiveBloc>().add(
                                    GetObjectiveQuestionsByBookmark(
                                        currentUnit.value,
                                        widget.subjectsubjectId),
                                  );
                            }
                            break;
                          case 3:
                            {
                              context.bloc<QuestionBankObjectiveBloc>().add(
                                    GetYourObjectiveQuestions(currentUnit.value,
                                        widget.subjectsubjectId),
                                  );
                            }
                            break;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder(
            cubit: context.bloc<UnitCubit>(),
            builder: (BuildContext context, state) {
              if (state is CourseUnitEmpty) {
                return Container();
              }
              if (state is CourseUnitFetched) {
                return BlocBuilder(
                  cubit: context.bloc<QuestionBankObjectiveBloc>(),
                  builder: (BuildContext context, state) {
                    if (state is UnitObjectiveQuestionsFetched) {
                      return Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: ListView(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(18.0),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(18.0),
                                        topRight: Radius.circular(18.0),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Objective Questions',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                50,
                                          ),
                                        ),
                                        RaisedButton(
                                          hoverColor:
                                              Color(0xFF1D2B64).withOpacity(.2),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            side: BorderSide(
                                              color: Color(0xFF1D2B64),
                                            ),
                                          ),
                                          onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  TypeQuestionTab(
                                                'Add New Objective Question',
                                                '',
                                                widget.subjectId,
                                                QuestionType.Objective,
                                                1234567890,
                                                true,
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                'Add Your Questions',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  BlocBuilder(
                                    cubit: context
                                        .bloc<QuestionBankObjectiveBloc>(),
                                    builder: (BuildContext context, state) {
                                      if (state
                                          is UnitObjectiveQuestionsFetched) {
                                        currentUnit.value = state.unitId;
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: state
                                              .questionBankObjectiveEntity
                                              .data
                                              .length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.black,
                                                    width: 0.5,
                                                  ),
                                                ),
                                              ),
                                              child: ListTile(
                                                title: Row(
                                                  children: [
                                                    Text('Q. ${index + 1}  '),
                                                    // Flexible(
                                                    //   child: TeXView(
                                                    //     child: TeXViewDocument(
                                                    //       state
                                                    //           .questionBankObjectiveEntity
                                                    //           .data[index]
                                                    //           .name
                                                    //         ..replaceAll("\$", ''),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                                subtitle: Text(
                                                  'Level ${state.questionBankObjectiveEntity.data[index].blooms_level}',
                                                ),
                                                trailing:
                                                    questionsDropDownValue == 3
                                                        ? PopupMenuButton(
                                                            onSelected:
                                                                (string) {
                                                              assert(string !=
                                                                  null);
                                                              switch (string) {
                                                                case 'Bookmark':
                                                                  _bookmark(state
                                                                      .questionBankObjectiveEntity
                                                                      .data[index]);
                                                                  break;
                                                                case 'Change type to Public':
                                                                  Get.defaultDialog(
                                                                    title:
                                                                        'Warning',
                                                                    middleText:
                                                                        'Once you change the type to public , you wont be able to revert it back to private',
                                                                    onConfirm:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      _changeType(
                                                                          state
                                                                              .questionBankObjectiveEntity
                                                                              .data[index]
                                                                              .id,
                                                                          'public');
                                                                    },
                                                                  );
                                                                  break;
                                                              }
                                                            },
                                                            itemBuilder:
                                                                (context) => [
                                                              PopupMenuItem(
                                                                child: Text(
                                                                  'Bookmark',
                                                                ),
                                                                value:
                                                                    'Bookmark',
                                                              ),
                                                              state
                                                                          .questionBankObjectiveEntity
                                                                          .data[
                                                                              index]
                                                                          .question_type ==
                                                                      'private'
                                                                  ? PopupMenuItem(
                                                                      child:
                                                                          Text(
                                                                        'Change to Public',
                                                                      ),
                                                                      value:
                                                                          'Change type to Public',
                                                                    )
                                                                  : null,
                                                            ],
                                                          )
                                                        : IconButton(
                                                            icon: Icon(state
                                                                        .questionBankObjectiveEntity
                                                                        .data[
                                                                            index]
                                                                        .bookmarked ==
                                                                    1
                                                                ? Icons.bookmark
                                                                : Icons
                                                                    .bookmark_border),
                                                            onPressed: () =>
                                                                _bookmark(
                                                              state
                                                                  .questionBankObjectiveEntity
                                                                  .data[index],
                                                            ),
                                                          ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                      if (state
                                          is QuestionBankObjectiveFetchFailed) {
                                        return Center(
                                            child: Text('No Questions'));
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
                          ),
                        ],
                      );
                    }
                    if (state is QuestionBankObjectiveFetchFailed) {
                      return Center(child: Text('No Questions'));
                    }
                    if (state is QuestionBankObjectiveEmpty) {
                      return Center(child: Text('No Questions'));


                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Questions'),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 12.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: DropdownButton(
                                  underline: SizedBox.shrink(),
                                  isExpanded: true,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('All Questions'),
                                      value: 1,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Bookmarked'),
                                      value: 2,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Your Questions'),
                                      value: 3,
                                    ),
                                  ],
                                  value: questionsDropDownValue,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        questionsDropDownValue = value;
                                        levelDropDownValue = -1;
                                        topicsDropDown = 1234567890;
                                      },
                                    );
                                    switch (value) {
                                      case 1:
                                        {
                                          context
                                              .bloc<QuestionBankObjectiveBloc>()
                                              .add(
                                                GetUnitObjectiveQuestions(
                                                  widget.subjectId,
                                                  state.unitId,
                                                ),
                                              );
                                        }
                                        break;
                                      case 2:
                                        {
                                          context
                                              .bloc<QuestionBankObjectiveBloc>()
                                              .add(
                                                GetObjectiveQuestionsByBookmark(
                                                    state.unitId,
                                                    widget.subjectsubjectId),
                                              );
                                        }
                                        break;
                                      case 3:
                                        {
                                          context
                                              .bloc<QuestionBankObjectiveBloc>()
                                              .add(
                                                GetYourObjectiveQuestions(
                                                    state.unitId,
                                                    widget.subjectsubjectId),
                                              );
                                        }
                                        break;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    'No Questions',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  RaisedButton(
                                    child: Text('Reload'),
                                    onPressed: () {
                                      context
                                          .bloc<QuestionBankObjectiveBloc>()
                                          .add(
                                            GetUnitObjectiveQuestions(
                                                widget.subjectId, state.unitId),
                                          );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
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
      ],
    );
  }

  _bookmark(Data data) async {
    bool isBookmarked = data.bookmarked == 1;

    if (isBookmarked) {
      final response = await EdwiselyApi.dio.post(
        'deleteBookmark',
        data: FormData.fromMap(
          {
            'type': data.type,
            'id': data.id,
          },
        ),
        options: Options(headers: {
          'Authorization': 'Bearer $loginToken',
        }),
      );
      if (response.data['message'] == 'Successfully deleted the bookmark') {
        setState(
          () => isBookmarked = false,
        );
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Some Error Occurred'),
          ),
        );
      }
    } else {
      final response = await EdwiselyApi.dio.post(
        'addBookmark',
        data: FormData.fromMap(
          {
            'type': data.type,
            'id': data.id,
          },
        ),
        options: Options(headers: {
          'Authorization': 'Bearer $loginToken',
        }),
      );
      if (response.data['message'] == 'Successfully added the bookmark') {
        setState(
          () => isBookmarked = true,
        );
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Some Error Occurred'),
          ),
        );
      }
    }
  }

  void _changeType(int id, String s) async {
    final response = await EdwiselyApi.dio.post(
      'questions/updateFacultyAddedObjectiveQuestions',
      data: FormData.fromMap(
        {
          'question_id': id,
          'type': s,
        },
      ),
      options: Options(headers: {
        'Authorization': 'Bearer $loginToken',
      }),
    );
    if (response.data['message'] == 'Successfully updated the data') {
      Toast.show('Changed the type to $s', context);
    } else {
      Toast.show('Cannot Change the type to $s', context);
    }
  }
}
