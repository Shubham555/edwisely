import 'package:dio/dio.dart';
import 'package:edwisely/data/api/api.dart';
import 'package:edwisely/data/blocs/questionBank/questionBankSubjective/question_bank_subjective_bloc.dart';
import 'package:edwisely/data/cubits/unit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionBankSubjectiveTab extends StatefulWidget {
  final int subjectId;

  QuestionBankSubjectiveTab(this.subjectId);

  @override
  _QuestionBankSubjectiveTabState createState() =>
      _QuestionBankSubjectiveTabState();
}

class _QuestionBankSubjectiveTabState extends State<QuestionBankSubjectiveTab> {
  int levelDropDownValue = -1;
  int topicsDropDown = 1234567890;
  int isSelected = 0;
  int questionsDropDownValue = 1;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder(
        cubit: context.bloc<QuestionBankSubjectiveBloc>(),
        builder: (BuildContext context, state) {
          if (state is UnitSubjectiveQuestionsFetched) {
            return Row(
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
                                      Text('Bloom Level'),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 0.0,
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
                                                  ? context
                                                      .bloc<
                                                          QuestionBankSubjectiveBloc>()
                                                      .add(
                                                        GetUnitSubjectiveQuestions(
                                                          widget.subjectId,
                                                          state.unitId,
                                                        ),
                                                      )
                                                  : context
                                                      .bloc<
                                                          QuestionBankSubjectiveBloc>()
                                                      .add(
                                                        GetUnitSubjectiveQuestionsByLevel(
                                                          value,
                                                          state.unitId,
                                                        ),
                                                      );
                                            }),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 18.0),
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
                                          vertical: 0.0,
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
                                          items: state.dropDownList,
                                          value: topicsDropDown,
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                topicsDropDown = value;
                                              },
                                            );
                                            value == 1234567890
                                                ? context
                                                    .bloc<
                                                        QuestionBankSubjectiveBloc>()
                                                    .add(
                                                      GetUnitSubjectiveQuestions(
                                                        widget.subjectId,
                                                        state.unitId,
                                                      ),
                                                    )
                                                : context
                                                    .bloc<
                                                        QuestionBankSubjectiveBloc>()
                                                    .add(
                                                      GetUnitSubjectiveQuestionsByTopic(
                                                        value,
                                                        state.unitId,
                                                      ),
                                                    );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 18.0),
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
                                                0.1,
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
                                                      .bloc<
                                                          QuestionBankSubjectiveBloc>()
                                                      .add(
                                                        GetUnitSubjectiveQuestions(
                                                          widget.subjectId,
                                                          state.unitId,
                                                        ),
                                                      );
                                                }
                                                break;
                                              case 2:
                                                {
                                                  context
                                                      .bloc<
                                                          QuestionBankSubjectiveBloc>()
                                                      .add(
                                                        GetSubjectiveQuestionsByBookmark(
                                                          state.unitId,
                                                        ),
                                                      );
                                                }
                                                break;
                                              case 3:
                                                {
                                                  context
                                                      .bloc<
                                                          QuestionBankSubjectiveBloc>()
                                                      .add(
                                                        GetYourSubjectiveQuestions(
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
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Subjective Questions',
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
                              cubit: context.bloc<QuestionBankSubjectiveBloc>(),
                              builder: (BuildContext context, state) {
                                if (state is UnitSubjectiveQuestionsFetched) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state
                                        .questionBankSubjectiveEntity
                                        .data
                                        .length,
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
                                              state.questionBankSubjectiveEntity
                                                  .data[index].question_img[0],
                                              width: 250,
                                              height: 120,
                                            ),
                                          ],
                                        ),
                                        subtitle: Text(
                                          'Level ${state.questionBankSubjectiveEntity.data[index].blooms_level}',
                                        ),
                                        trailing: StatefulBuilder(
                                          builder: (BuildContext context,
                                              void Function(void Function())
                                                  setState) {
                                            bool isBookmarked = state
                                                    .questionBankSubjectiveEntity
                                                    .data[index]
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
                                                                      .questionBankSubjectiveEntity
                                                                      .data[
                                                                          index]
                                                                      .type,
                                                                  'id': state
                                                                      .questionBankSubjectiveEntity
                                                                      .data[
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
                                                                      .questionBankSubjectiveEntity
                                                                      .data[
                                                                          index]
                                                                      .type,
                                                                  'id': state
                                                                      .questionBankSubjectiveEntity
                                                                      .data[
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
                                if (state
                                    is QuestionBankSubjectiveFetchFailed) {
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
