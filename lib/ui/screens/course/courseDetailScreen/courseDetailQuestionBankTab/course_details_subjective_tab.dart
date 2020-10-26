import 'package:dio/dio.dart';
import 'package:edwisely/data/model/questionBank/questionBankSubjective/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

import '../../../../../data/api/api.dart';
import '../../../../../data/blocs/questionBank/questionBankSubjective/question_bank_subjective_bloc.dart';
import '../../../../../main.dart';

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
    return BlocBuilder(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Bloom Level'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.07,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 12.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Topic'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.07,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 12.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Questions'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 12.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
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
                                RaisedButton(
                                  hoverColor: Color(0xFF1D2B64).withOpacity(.2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  onPressed: () => null,
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
                            cubit: context.bloc<QuestionBankSubjectiveBloc>(),
                            builder: (BuildContext context, state) {
                              if (state is UnitSubjectiveQuestionsFetched) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state
                                        .questionBankSubjectiveEntity
                                        .data
                                        .length,
                                    itemBuilder: (BuildContext context,
                                            int index) =>
                                        Container(
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
                                                Text('Q. ${index + 1}'),
                                                Image.network(
                                                  state
                                                      .questionBankSubjectiveEntity
                                                      .data[index]
                                                      .question_img[0],
                                                  width: 250,
                                                  height: 120,
                                                ),
                                              ],
                                            ),
                                            subtitle: Text(
                                              'Level ${state.questionBankSubjectiveEntity.data[index].blooms_level}',
                                            ),
                                            trailing: questionsDropDownValue ==
                                                    3
                                                ? PopupMenuButton(
                                                    onSelected: (string) {
                                                      switch (string) {
                                                        case 'Bookmark':
                                                          _bookmark(state
                                                              .questionBankSubjectiveEntity
                                                              .data[index]);
                                                          break;
                                                        case 'Change type to Public':
                                                          Get.defaultDialog(
                                                            title: 'Confirm',
                                                            middleText:
                                                                'You wont be able to change it back to private once a question is made public',
                                                            onConfirm: () {
                                                              Get.back();
                                                              _changeType(
                                                                    state
                                                                        .questionBankSubjectiveEntity
                                                                        .data[
                                                                            index]
                                                                        .id,
                                                                    'public');
                                                            },
                                                            onCancel: () =>
                                                                Get.back(),
                                                          );
                                                          break;
                                                        case 'Change type to Private':
                                                          _changeType(
                                                              state
                                                                  .questionBankSubjectiveEntity
                                                                  .data[index]
                                                                  .id,
                                                              'private');
                                                          break;
                                                      }
                                                    },
                                                    itemBuilder: (context) {
                                                      return [
                                                        'Bookmark',
                                                        'Change type to ${state.questionBankSubjectiveEntity.data[index].question_type == 'public' ? 'Private' : 'Public'}',
                                                      ] // 'Change Type to ${state.data[index].display_type == 'public' ? 'Private' : 'Public'}']
                                                          .map(
                                                            (e) =>
                                                                PopupMenuItem(
                                                              child: Text(e),
                                                              value: e,
                                                            ),
                                                          )
                                                          .toList();
                                                    },
                                                  )
                                                : IconButton(
                                                    icon: Icon(state
                                                                .questionBankSubjectiveEntity
                                                                .data[index]
                                                                .bookmarked ==
                                                            1
                                                        ? Icons.bookmark
                                                        : Icons
                                                            .bookmark_border),
                                                    onPressed: () => _bookmark(
                                                      state
                                                          .questionBankSubjectiveEntity
                                                          .data[index],
                                                    ),
                                                  ),
                                          ),
                                        ));
                              }
                              if (state is QuestionBankSubjectiveFetchFailed) {
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
      'questions/updateFacultyAddedSubjectiveQuestions',
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
