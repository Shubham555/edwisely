import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/blocs/questionBank/question_bank_bloc.dart';
import 'package:edwisely/data/cubits/unit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionBankAllTab extends StatefulWidget {
  final int subjectId;
  final TabController _tabController;

  QuestionBankAllTab(this.subjectId, this._tabController);

  @override
  _QuestionBankAllTabState createState() => _QuestionBankAllTabState();
}

class _QuestionBankAllTabState extends State<QuestionBankAllTab> {
  int levelDropDownValue = -1;
  int topicsDropDown = 1234567890;
  int isSelected = 0;
  int questionsDropDownValue = 1;
  int unitSeleceted;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder(
        cubit: context.bloc<QuestionBankBloc>(),
        builder: (BuildContext context, state) {
          if (state is UnitQuestionsFetched) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListView(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 16.0,
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Level'),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4.0,
                                          horizontal: 12.0,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: DropdownButton(
                                          underline: SizedBox.shrink(),
                                          isExpanded: true,
                                          items: [
                                            DropdownMenuItem(
                                              child: Text('All'),
                                              value: -1,
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
                                                ? context
                                                    .bloc<QuestionBankBloc>()
                                                    .add(
                                                      GetUnitQuestions(
                                                        widget.subjectId,
                                                        state.unitId,
                                                      ),
                                                    )
                                                : context
                                                    .bloc<QuestionBankBloc>()
                                                    .add(
                                                      GetUnitQuestionsByLevel(
                                                        value,
                                                        state.unitId,
                                                      ),
                                                    );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Topic'),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4.0,
                                          horizontal: 12.0,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: DropdownButton(
                                          items: state.dropDownList,
                                          value: topicsDropDown,
                                          underline: SizedBox.shrink(),
                                          isExpanded: true,
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                topicsDropDown = value;
                                              },
                                            );
                                            value == 1234567890
                                                ? context
                                                    .bloc<QuestionBankBloc>()
                                                    .add(
                                                      GetUnitQuestions(
                                                        widget.subjectId,
                                                        state.unitId,
                                                      ),
                                                    )
                                                : context
                                                    .bloc<QuestionBankBloc>()
                                                    .add(
                                                      GetUnitQuestionsByTopic(
                                                        value,
                                                        state.unitId,
                                                      ),
                                                    );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Questions'),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4.0,
                                          horizontal: 12.0,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          border:
                                              Border.all(color: Colors.black),
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
                                                  context
                                                      .bloc<QuestionBankBloc>()
                                                      .add(
                                                        GetQuestionsByBookmark(
                                                          state.unitId,
                                                        ),
                                                      );
                                                }
                                                break;
                                              case 2:
                                                {
                                                  context
                                                      .bloc<QuestionBankBloc>()
                                                      .add(
                                                        GetQuestionsByBookmark(
                                                          state.unitId,
                                                        ),
                                                      );
                                                }
                                                break;
                                              case 3:
                                                {
                                                  context
                                                      .bloc<QuestionBankBloc>()
                                                      .add(
                                                        GetYourQuestions(
                                                          state.unitId,
                                                        ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Subjective Questions',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                50,
                                      ),
                                    ),
                                    FlatButton(
                                      hoverColor:
                                          Color(0xFF1D2B64).withOpacity(.2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        side: BorderSide(
                                          color: Color(0xFF1D2B64),
                                        ),
                                      ),
                                      onPressed: () => null,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            color: Color(0xFF1D2B64),
                                          ),
                                          Text(
                                            'Add Your Questions',
                                            style: TextStyle(
                                              color: Color(0xFF1D2B64),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                BlocBuilder(
                                  cubit: context.bloc<QuestionBankBloc>(),
                                  builder: (BuildContext context, state) {
                                    if (state is UnitQuestionsFetched) {
                                      if (state.questionBankAllEntity.data
                                          .subjective_questions.isEmpty) {
                                        return Center(
                                          child: Text(
                                            'No Questions',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30),
                                          ),
                                        );
                                      }
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: state.questionBankAllEntity
                                            .data.subjective_questions.length,
                                        itemBuilder:
                                            (BuildContext context, int index) =>
                                                Card(
                                          margin: EdgeInsets.all(
                                            10,
                                          ),
                                          child: ListTile(
                                            title: Row(
                                              children: [
                                                Text('Q. ${index + 1}'),
                                                Image.network(
                                                  state
                                                      .questionBankAllEntity
                                                      .data
                                                      .subjective_questions[
                                                          index]
                                                      .question_img[0],
                                                  width: 250,
                                                  height: 120,
                                                ),
                                              ],
                                            ),
                                            subtitle: Text(
                                              'Level ${state.questionBankAllEntity.data.subjective_questions[index].blooms_level}',
                                            ),
                                            trailing: StatefulBuilder(
                                              builder: (BuildContext context,
                                                  void Function(void Function())
                                                      setState) {
                                                bool isBookmarked = state
                                                        .questionBankAllEntity
                                                        .data
                                                        .subjective_questions[
                                                            index]
                                                        .bookmarked ==
                                                    1;
                                                return IconButton(
                                                  icon: Icon(
                                                    isBookmarked
                                                        ? Icons.bookmark
                                                        : Icons.bookmark_border,
                                                  ),
                                                  onPressed: () async {
                                                    //going the easy way allah maaf kre
                                                    if (isBookmarked) {
                                                      final response =
                                                          await EdwiselyApi()
                                                              .dio()
                                                              .then(
                                                                (value) =>
                                                                    value.post(
                                                                  'deleteBookmark',
                                                                  data: FormData
                                                                      .fromMap(
                                                                    {
                                                                      'type': state
                                                                          .questionBankAllEntity
                                                                          .data
                                                                          .subjective_questions[
                                                                              index]
                                                                          .type,
                                                                      'id': state
                                                                          .questionBankAllEntity
                                                                          .data
                                                                          .subjective_questions[
                                                                              index]
                                                                          .id,
                                                                    },
                                                                  ),
                                                                ),
                                                              );
                                                      print(response.data);
                                                      if (response.data[
                                                              'message'] ==
                                                          'Successfully deleted the bookmark') {
                                                        setState(
                                                          () => isBookmarked =
                                                              false,
                                                        );
                                                      } else {
                                                        Scaffold.of(context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                                'Some Error Occurred'),
                                                          ),
                                                        );
                                                      }
                                                    } else {
                                                      final response =
                                                          await EdwiselyApi()
                                                              .dio()
                                                              .then(
                                                                (value) =>
                                                                    value.post(
                                                                  'addBookmark',
                                                                  data: FormData
                                                                      .fromMap(
                                                                    {
                                                                      'type': state
                                                                          .questionBankAllEntity
                                                                          .data
                                                                          .subjective_questions[
                                                                              index]
                                                                          .type,
                                                                      'id': state
                                                                          .questionBankAllEntity
                                                                          .data
                                                                          .subjective_questions[
                                                                              index]
                                                                          .id,
                                                                    },
                                                                  ),
                                                                ),
                                                              );
                                                      print(response.data);

                                                      if (response.data[
                                                              'message'] ==
                                                          'Successfully added the bookmark') {
                                                        setState(
                                                          () => isBookmarked =
                                                              true,
                                                        );
                                                      } else {
                                                        Scaffold.of(context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                                'Some Error Occurred'),
                                                          ),
                                                        );
                                                      }
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    if (state is QuestionBankFetchFailed) {
                                      return Center(
                                        child: Text(
                                          'No Questions',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                                FlatButton(
                                  hoverColor: Color(0xFF1D2B64).withOpacity(.2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    side: BorderSide(
                                      color: Color(0xFF1D2B64),
                                    ),
                                  ),
                                  onPressed: () =>
                                      widget._tabController.index = 2,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Color(0xFF1D2B64),
                                      ),
                                      Text(
                                        'View More',
                                        style: TextStyle(
                                          color: Color(0xFF1D2B64),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 3,
                          color: Colors.grey,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Objective Questions',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.height / 50,
                                  ),
                                ),
                                FlatButton(
                                  hoverColor: Color(0xFF1D2B64).withOpacity(.2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    side: BorderSide(
                                      color: Color(0xFF1D2B64),
                                    ),
                                  ),
                                  onPressed: () => null,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Color(0xFF1D2B64),
                                      ),
                                      Text(
                                        'Add Your Questions',
                                        style: TextStyle(
                                          color: Color(0xFF1D2B64),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            BlocBuilder(
                              cubit: context.bloc<QuestionBankBloc>(),
                              builder: (BuildContext context, state) {
                                if (state is UnitQuestionsFetched) {
                                  if (state.questionBankAllEntity.data
                                      .objective_questions.isEmpty) {
                                    return Center(
                                      child: Text(
                                        'No Questions',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                    );
                                  }
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.questionBankAllEntity.data
                                        .objective_questions.length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            Card(
                                      margin: EdgeInsets.all(10),
                                      child: ListTile(
                                        title: Row(
                                          children: [
                                            Text('Q. ${index + 1}  '),
                                            Expanded(
                                                child: Text(
                                              state
                                                  .questionBankAllEntity
                                                  .data
                                                  .objective_questions[index]
                                                  .name,
                                            )),
                                          ],
                                        ),
                                        subtitle: Text(
                                          'Level ${state.questionBankAllEntity.data.objective_questions[index].blooms_level}',
                                        ),
                                        trailing: StatefulBuilder(
                                          builder: (BuildContext context,
                                              void Function(void Function())
                                                  setState) {
                                            bool isBookmarked = state
                                                    .questionBankAllEntity
                                                    .data
                                                    .subjective_questions[index]
                                                    .bookmarked ==
                                                1;
                                            return IconButton(
                                              icon: Icon(
                                                isBookmarked
                                                    ? Icons.bookmark
                                                    : Icons.bookmark_border,
                                              ),
                                              onPressed: () async {
                                                //going the easy way allah maaf kre
                                                if (isBookmarked) {
                                                  final response =
                                                      await EdwiselyApi()
                                                          .dio()
                                                          .then(
                                                            (value) =>
                                                                value.post(
                                                              'deleteBookmark',
                                                              data: FormData
                                                                  .fromMap(
                                                                {
                                                                  'type': state
                                                                      .questionBankAllEntity
                                                                      .data
                                                                      .subjective_questions[
                                                                          index]
                                                                      .type,
                                                                  'id': state
                                                                      .questionBankAllEntity
                                                                      .data
                                                                      .subjective_questions[
                                                                          index]
                                                                      .id,
                                                                },
                                                              ),
                                                            ),
                                                          );
                                                  print(response.data);
                                                  if (response
                                                          .data['message'] ==
                                                      'Successfully deleted the bookmark') {
                                                    setState(
                                                      () =>
                                                          isBookmarked = false,
                                                    );
                                                  } else {
                                                    Scaffold.of(context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Some Error Occurred'),
                                                      ),
                                                    );
                                                  }
                                                } else {
                                                  final response =
                                                      await EdwiselyApi()
                                                          .dio()
                                                          .then(
                                                            (value) =>
                                                                value.post(
                                                              'addBookmark',
                                                              data: FormData
                                                                  .fromMap(
                                                                {
                                                                  'type': state
                                                                      .questionBankAllEntity
                                                                      .data
                                                                      .subjective_questions[
                                                                          index]
                                                                      .type,
                                                                  'id': state
                                                                      .questionBankAllEntity
                                                                      .data
                                                                      .subjective_questions[
                                                                          index]
                                                                      .id,
                                                                },
                                                              ),
                                                            ),
                                                          );
                                                  print(response.data);

                                                  if (response
                                                          .data['message'] ==
                                                      'Successfully added the bookmark') {
                                                    setState(
                                                      () => isBookmarked = true,
                                                    );
                                                  } else {
                                                    Scaffold.of(context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Some Error Occurred'),
                                                      ),
                                                    );
                                                  }
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                if (state is QuestionBankFetchFailed) {
                                  return Center(
                                    child: Text(
                                      'No Questions',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            FlatButton(
                              hoverColor: Color(0xFF1D2B64).withOpacity(.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                                side: BorderSide(
                                  color: Color(0xFF1D2B64),
                                ),
                              ),
                              onPressed: () => widget._tabController.index = 1,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Color(0xFF1D2B64),
                                  ),
                                  Text(
                                    'View More',
                                    style: TextStyle(
                                      color: Color(0xFF1D2B64),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          if (state is QuestionBankFetchFailed) {
            return Center(
              child: Text(
                'No Questions',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
